CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => Settings.carrierwave.provider,                       # required
    :aws_access_key_id      => Settings.carrierwave.aws_access_key_id,              # required
    :aws_secret_access_key  => Settings.carrierwave.aws_secret_access_key,          # required
    :region                 => Settings.carrierwave.region,                         # optional, defaults to 'us-east-1'
    :host                   => Settings.carrierwave.host,                           # optional, defaults to nil
    :endpoint               => Settings.carrierwave.endpoint                        # optional, defaults to nil
  }
  config.fog_directory  = Settings.carrierwave.fog_directory                        # required
  config.fog_public     = true                                                      # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}                    # optional, defaults to {}
end
