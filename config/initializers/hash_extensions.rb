class Hash
  def merge_with_string_concat(hash)
    result = self.merge(hash)
    hash.each_pair do |key, value|
      if self.has_key?(key) && self[key].is_a?(String) && value.is_a?(String)
        result[key] = self[key].concat(" ").concat(value)
      end
    end
    result
  end
end
