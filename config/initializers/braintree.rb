Braintree::Configuration.environment  = ENV['BRAINTREE_ENV']         || :sandbox
Braintree::Configuration.merchant_id  = ENV['BRAINTREE_MERCHANT_ID'] || 'knyxszzw63fdbhch'
Braintree::Configuration.public_key   = ENV['BRAINTREE_PUBLIC_KEY']  || 'sgmzbvk6v8d7hc3c'
Braintree::Configuration.private_key  = ENV['BRAINTREE_PRIVATE_KEY'] || 'bd597afe0eea1915d23dabc174f0e28b'