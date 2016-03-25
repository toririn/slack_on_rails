module Togethers::Outputs

  def output
    if params.include?(:save)
      output_for_mysql
    elsif params.include?(:lodge)
      date = output_for_lodge
      filename = Time.new.strftime("%Y%m%d%H%M%S") + ".txt"
    end
    send_data(date, type: 'text/csv', filename: filename)
  end

  private

  def output_for_mysql
    #TODO: MySQLへの保存処理
  end

  def output_for_lodge
    lodge_support = ::Outputs::LodgeSupport.new(set_lodge_params)
    lodge_support.output_date('markdown')
  end

  def set_lodge_params
    params.permit(images: [], names: [], texts: [], channels: [], links: [], tss: [])
  end
end
