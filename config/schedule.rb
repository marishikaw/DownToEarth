# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 絶対パスを取得
require File.expand_path(File.dirname(__FILE__) + "/environment")

# 現在の環境をシンボル型で取得
rails_env = Rails.env.to_sym

set :environment, rails_env
set :output, 'log/cron.log'

every 1.hours do
  begin
    runner "Batch::DataReset.data_reset"
  # 例外処理　エラー内容を格納
  rescue => e
    # ログに出力
    Rails.logger.error("aborted rails runner")
    # エラーを明示的に発生させる
    raise e
  end
end
