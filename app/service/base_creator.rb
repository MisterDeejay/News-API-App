class BaseCreator
  attr_accessor :record, :errors
  def initialize(klass, params)
    @klass, @params = klass, params
    @errors = []
  end

  def run
    begin
      @record = @klass.constantize.new
      record.update_attributes!(@params)
    rescue => e
      errors << e
    end
  end

  class Error < StandardError; end
end
