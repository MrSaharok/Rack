class TimeService

  TIME_FORMATS = {
    year:   '%Y',
    month:  '%m',
    day:    '%d',
    hour:   '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :errors

  def initialize(request)
    @errors = []
    @params = check_params request

  end

  def parse
    check_time = @params.map { |format| TIME_FORMATS[format] }.join('-')
    Time.new.strftime check_time
  end

  private

  def check_params(request)
    @errors << '"Unknown time format' && return unless request.params['format']

    request.params['format'].split(',').map(&:to_sym).tap do |params|
      validate_format(params)
    end
  end

  def validate_format(params)
    format_errors = params.reject { |f| TIME_FORMATS.key? f }
    @errors << "Unknown time format #{format_errors}" unless format_errors.empty?
  end
end
