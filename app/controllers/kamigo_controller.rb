require 'net/http'
class KamigoController < ApplicationController
	def eat
		render plain: "測試"
	end

	def request_headers
		# render plain: request.headers.to_h.keys.sort.join("\n")
		# render plain: request.headers.to_h.map{ |key, value|
		# 	key + ": " + value.class.to_s
		# }.sort.join("\n")
		# render plain: request.headers.to_h.map{ |key, value|
		# 	"#{key}: #{value.class}"
		# }.sort.join("\n")
		render plain: request.headers.to_h.reject{ |key,value|
			key.include? '.'
		}.map{ |key, value|
			"#{key}: #{value}"
		}.sort.join("\n")
	end

	def request_body
		render plain: request.body
	end

	def response_headers
		response.headers['5566'] = 'QQ'
		render plain: response.headers.to_h.map{ |key,value|
			"#{key}: #{value}"
	}.sort.join("\n")
	end

	def show_response_body
		puts "----------------------------設定前:#{response.body}"
		render plain: "12345"
		puts "----------------------------設定後:#{response.body}"
	
	end

	def sent_request
		uri = URI('http://localhost:3000/kamigo/response_body')
		http = Net::HTTP.new(uri.host, uri.port)
		http_request = Net::HTTP::Get.new(uri)
		http_response = http.request(http_request)
		render plain: JSON.pretty_generate({
			request_class: request.class,
			response_class: response.class,
			http_request_class: http_request.class,
			http_response_class: http_response.class
		})

		# response = Net::HTTP.get(uri).force_encoding("UTF-8")
		# render plain: translate_to_korean(response)
	end

	def translate_to_korean(message)
		"#{message}油~"
	
	end

end
