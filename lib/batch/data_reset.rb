class Batch::DataReset
  def self.data_reset
    User.where(id: 19..Float::INFINITY).destroy_all
    Hashtag.where(id: 11..Float::INFINITY).destroy_all
    p "データを削除しました"
  end
end
