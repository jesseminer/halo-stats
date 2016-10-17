class BaseSerializer
  def self.serialize_list(list)
    list.map { |item| serialize(item) }
  end
end