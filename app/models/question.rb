class Question < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  class << self
    # 根据关键字搜索已发布的文章
    # 最多返回100条记录
    # user限制搜索范围
    def search_by_token(token)
      opts = {
        size: 100,
        query: {
          bool: {
            must: [
              { multi_match: 
                {
                  query: token.to_s,
                  fields: ['title', 'content']
                } 
              }
            ]
          }
        },
        highlight: {
          pre_tags: ["<strong>"],
          post_tags: ["</strong>"],
          number_of_fragments: 1,
          fragment_size: 100,
          fields: {
              title: { number_of_fragments: 0 },
              content: {}
          }
        }
      }
      search(opts).records
    end

  end
end
