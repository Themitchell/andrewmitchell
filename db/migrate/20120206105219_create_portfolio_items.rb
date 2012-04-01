class CreatePortfolioItems < ActiveRecord::Migration
  def change
    create_table :portfolio_items do |t|
      t.string    :title
      t.string    :permalink
      t.string    :description
      t.datetime  :published_on
      t.integer   :author_id

      t.timestamps
    end
  end
end
