class Format

  attr_reader :time, :unknown

  FORMAT = { 'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
             'hour' => ' %H:', 'minute' => '%M:', 'second' => '%S'}.freeze

  def initialize(params)
    @valid = ''
    @unknown = []
    @time = ''
    time_format(params)
  end

  def success?
    @unknown.empty?
  end

  private

  def time_format(params)
    check_params(params['format'].split(',')) if params['format']
  end

  def check_params(params)
    params.each do |format|
      if FORMAT[format]
        @valid += FORMAT[format]
      else
        @unknown << format
      end
    end

    @time = Time.now.strftime(@valid) + "\n"
  end
end
