class PdfMailer < ApplicationMailer
  def send_report(user)
    @message = "Hey, here is your test report, #{user.first_name}."

    # Datos dinámicos para el PDF
    user_data = {
      name: "#{user.first_name} #{user.last_name}",  # Nombre completo
      email: user.email,                            # Correo
      role: user.role,                              # Rol del usuario
      status: user.status,                          # Estado del usuario
      results: []                                   # Aquí puedes añadir los resultados de pruebas si los tienes
    }

    # Genera el PDF con los datos del usuario
    pdf_service = PdfGeneratorService.new(user_data)
    pdf_content = pdf_service.generate_pdf

    # Adjunta el PDF
    attachments['test_result_report.pdf'] = { mime_type: 'application/pdf', content: pdf_content }

    mail(to: user.email, subject: 'Your Test Report')
  end
end
