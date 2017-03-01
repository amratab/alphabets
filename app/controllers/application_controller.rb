class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def home
    logger = Logger.new("#{Rails.root}/log/alexa_handler.log")
    handler = AlexaHandler.new(skip_signature_validation: !Rails.env.staging? , application_id: 'amzn1.ask.skill.47862925-683b-41f2-a9f1-7885641b0add', logger: logger)
    begin
      # hdrs = { 'Signature' => request.env['HTTP_SIGNATURE'], 'SignatureCertChainUrl' => request.env['HTTP_SIGNATURECERTCHAINURL'] }
      response = handler.handle(request.body.read, nil)
      # response.should_end_session = false
      logger.info( response )
    rescue AlexaSkillsRuby::Error => e
      logger.error e.message
      e.backtrace.each { |line| logger.error line }
      # Airbrake.notify(e )
    end
    render :json => response
  end
end
