class Url < ActiveRecord::Base
	validates :base_url, uniqueness: true, presence: true
	validates_format_of :base_url, :with => /(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/, :message => "must be prefixed with one of these www,http,https" 
	after_create :generate_short_url

	def generate_short_url
		rand = 10000 + self.id
		self.short_value = rand.to_s(36)
		self.short_url = Settings.base_url + '/' + rand.to_s(36)
		self.save
	end

	def get_redirect_url
		self.base_url.split('.')[0] == 'www' ? "http://" + self.base_url : self.base_url
	end
end
