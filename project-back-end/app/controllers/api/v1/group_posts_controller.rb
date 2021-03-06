module Api
  module V1
    class GroupPostsController < ApiController
      before_action :authenticate_user! 
      before_action :set_group
  
      def posts
        authorize @group, policy_class: GroupPostsPolicy
        posts = @group.posts
        posts = filter(posts)
        posts = order(posts)
        length = posts.length
        posts = pagination(posts, params[:per_page], params[:page_no])
        render json: posts, record_count: length, user: current_user, status: 200 
      end 
      
      def create 
        authorize @group, policy_class: GroupPostsPolicy 
        begin
          Post.transaction do
            post = current_user.posts.new(post_create_params)
            post.visibility = :hidden
            post.save!  
            post.post_groups.create!(group_id: params[:id])

            if params[:tags].present?
              tags = Tag.where(name: params[:tags])
              post.post_tags.create!(tags.map { |tag| { tag_id: tag.id } } )  
            end   
            created_response(post)
          end
        rescue => exception
          bad_request_response({ error: exception })
        end    
      end

      private 
      
      def set_group 
        @group = Group.find_by(id: params[:id]) 
         
        if @group.nil?
          record_not_found_response
        end 
      end  

      def filter(posts)     
        if params[:tag].present?
          tag = Tag.find_by(name: params[:tag])
          if tag
            posts = posts.joins(:tags).where(tags: {id: tag.id })
          else 
            return Post.none  
          end
        end  

        if params[:title].present? 
          posts = posts.where('lower(title) like ?', 
                                "%#{params[:title].downcase}%")  
        end  
        posts 
      end   

      def order(posts)
        if params[:sort].present? && params[:sort] == 'asc'  
          posts = posts.order(created_at: :asc)
        else     
          posts = posts.order(created_at: :desc) 
        end 
        posts
      end 
      
      def post_create_params 
        params.permit(:title, :description)
      end
    end 
  end 
end
