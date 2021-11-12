namespace :score do
  desc "计算idea的得分"
  task calculate: :environment do
    # 只有完成状态才计算:  <31-08-21, clliu> #
    @golden_ideas = GoldenIdea::Idea.where(season_id: GoldenIdea::Season.last.id)
    @golden_ideas.each do |idea|
      if idea.score_records.length > 3
        scores = idea.score_records.map(&:score)
        scores = scores.sort.slice(1..-2)
        idea.update(score: scores.sum/scores.length)
      end
    end
  end

end
