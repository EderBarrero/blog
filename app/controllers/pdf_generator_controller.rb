require 'ostruct'

class PdfGeneratorController < ApplicationController
  def generate_pdf

    start_date = params[:start_date]
    end_date = params[:end_date]

    unless start_date.blank? || end_date.blank?
      users = User.filter_date(start_date, end_date)
    else
      users = User.all
      start_date = nil
      end_date = nil
    end

    user_data = users.map do |user|
      OpenStruct.new(
        id: user.id,
        name: "#{user.first_name} #{user.last_name}",
        email: user.email,
        role: user.role,
        status: user.status
      )
    end

    pdf_generator = PdfGeneratorService.new(user_data, current_user.email,start_date, end_date)

    pdf_content = pdf_generator.generate_pdf

    send_data pdf_content, filename: "users_netbook_report.pdf", type: "application/pdf"
  end
end
