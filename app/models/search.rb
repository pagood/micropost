class Search
	attr_accessor :result
	def search(key_word)
		User.where('user_name LIKE ?', "%#{key_word}%")
	end
end
