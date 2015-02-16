class StaticPagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:checkout]
  

	def index
		# @client_token = Braintree::ClientToken.generate
		@main_topics = Topic.where(forum_id: Forum.where(main_feed: true).pluck(:id)).order(:created_at).order(:sticky)
	end

	def cert
		send_file "#{Rails.root}/tmp/certificates/ssl.crt"
	end

	def create
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

	def admin_panel
		@games = Game.all.order(:title)
		@game_instances = GameInstance.all.order(:title)
	end

end