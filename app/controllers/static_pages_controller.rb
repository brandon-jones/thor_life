class StaticPagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:checkout]

	def index
		# @client_token = Braintree::ClientToken.generate
		@main_topics = Topic.where(forum_id: Forum.where(main_feed: true).pluck(:id))
	end

	def cert
		send_file "#{Rails.root}/tmp/certificates/ssl.crt"
	end

	def create
		binding.pry
		redirect_to root_path
	end

	def checkout
	  nonce = params[:payment_method_nonce]
	  render action: :new and return unless nonce
	  result = Braintree::Transaction.sale(
	    amount: "10.00",
	    payment_method_nonce: nonce
	  )

	  flash[:notice] = "Sale successful. Head to Sizzler" if result.success?
	  flash[:alert] = "Something is amiss. #{result.transaction.processor_response_text}" unless result.success?
	  redirect_to action: :new
	end

end