require 'base64'
require 'json'

module Services
    class Pagination
        Max_page_size = 3

        def initialize(page_token, topic_id = nil)
            @current_page = parse_page_token(page_token)
            @topic_id = topic_id
        end

        def newer
            @posts = Post.order(id: :asc).where(where_newer(@current_page["largest_id"])).limit(Max_page_size)
            @posts = @posts.reverse()
            return @posts
        end

        def older
            @posts = Post.order(id: :desc).where(where_older(@current_page["smallest_id"])).limit(Max_page_size)
            return @posts
        end

        def first_page
            if @topic_id.present?
                @posts = Post.order(id: :desc).where(["topic_id = ?", [@topic_id]]).limit(Max_page_size)
            else
                @posts = Post.order(id: :desc).limit(Max_page_size)
            end

            return @posts
        end

        def has_newer
            if !@posts.present?
                return false
            end
            @has_newer = Post.where(where_newer(@posts[0].id)).limit(1).length > 0
        end

        def has_older
            if !@posts.present?
                return false
            end

            @has_older = Post.where(where_older(@posts[-1].id)).limit(1).length > 0
        end

        def construct_page_token
            if !@posts.present?
                return nil
            end

            return Base64.encode64("{\"largest_id\":#{@posts[0].id},\"smallest_id\":#{@posts[-1].id}}")
        end

        private
        def parse_page_token(page_token)
            if !page_token.present?
                return nil
            end
            page_token_json = Base64.decode64(page_token)
            page_params = JSON.parse(page_token_json)
            params_valid = 
                page_params["smallest_id"].present? && 
                page_params["largest_id"].present? && 
                page_params["smallest_id"].is_a?(Integer) && 
                page_params["largest_id"].is_a?(Integer)
        
            if !params_valid
                return nil
            end
            return page_params
        end

        def where_older(id)
            filter = "id < ?"

            return add_topic_filter([filter, id])
        end

        def where_newer(id)
            filter = "id > ?"
            return add_topic_filter([filter, id])
        end

        def add_topic_filter(where)
            if @topic_id.present?
                where[0] += " AND topic_id = ?"
                where += [@topic_id]    
            end
            return where
        end
    end
end