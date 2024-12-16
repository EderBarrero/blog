require 'ostruct'

class PdfGeneratorController < ApplicationController
  def generate_pdf
    users = User.all

    # Construimos un array de hashes con los datos de cada usuario
    user_data = users.map do |user|
      OpenStruct.new(
        id: user.id,
        name: "#{user.first_name} #{user.last_name}",
        email: user.email,
        role: user.role,
        status: user.status
      )
    end

    # Pasamos los datos al servicio
    pdf_generator = PdfGeneratorService.new(user_data, current_user.email)

    # Generamos el PDF
    pdf_content = pdf_generator.generate_pdf

    # Enviamos el PDF como respuesta
    send_data pdf_content, filename: "users_netbook_report.pdf", type: "application/pdf"
  end
end
