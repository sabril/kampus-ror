class ApiVersion
  attr_reader :version, :default
  
  def initialize(version, default = false)
    @version = version
    @default = default
  end
  
  def matches?(request)
    check_headers(request.headers) || default
  end
  
  def check_headers(headers)
    accept = headers[:accept]
    puts accept.include?("application/vnd.kampus-ror.#{version}+json")
    accept && accept.include?("application/vnd.kampus-ror.#{version}+json")
  end
end