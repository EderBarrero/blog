# app/services/pdf_generator_service.rb

require 'prawn'

class PdfGeneratorService
  # Actualiza las rutas de las fuentes para que apunten a las fuentes locales
  MONTSERRAT_FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'Montserrat-Medium.ttf')
  MONTSERRAT_BOLD_FONT_PATH = Rails.root.join('app', 'assets', 'fonts', 'Montserrat-Bold.ttf')
  LOGO_IMG_PATH = Rails.root.join('app', 'assets', 'images', 'aba_tech_logo.png')

  def initialize(user_data, email_initializer)
    @email_initializer = email_initializer
    @user_data = user_data
    @pdf = Prawn::Document.new
    @document_width = @pdf.bounds.width
    @pdf.font_families.update(
      'montserrat' => {
        normal: MONTSERRAT_FONT_PATH, # Ruta a la fuente normal
        bold: MONTSERRAT_BOLD_FONT_PATH # Ruta a la fuente en negrita
      }
    )
  end

  def generate_pdf
    header
    mid_section
    result_section
    @pdf.render
  end

  def header
    status_results = [["#{ @user_data.count }", 
    "#{@user_data.count { |e| e.status == 'active' }}", 
    "#{@user_data.count { |e| e.status == 'inactive' }}", 
    "#{@user_data.count { |e| e.role == 'user' }}",
    "#{@user_data.count { |e| e.role == 'admin' }}"], %w[ALL ACTIVE INACTIVE USERS ADMINS]]
    text_colors = { 1 => '83BC41', 2 => 'C8102F', 3 => 'FDB357', 4 => 'BBBBBB' }

    header_table = @pdf.make_table(status_results) do |table|
      table.row(0).font_style = :bold
      table.row(0).font = 'montserrat'

      header_status_rows = [0, 1]
      header_status_rows.each do |row_index|
        text_colors.each do |column_index, color|
          table.row(row_index).column(column_index).style(text_color: color)
        end
      end

      table.row(0..1).border_width = 0
      table.row(0..1).column(0).border_width = 1
      table.row(0..1).column(0).border_color = 'c0c5ce'
      table.row(0..1).column(0).borders = [:right]
      
      table.row(0..1).column(2).border_width = 1
      table.row(0..1).column(2).border_color = 'c0c5ce'
      table.row(0..1).column(2).borders = [:right]
      

      table.row(0).size = 17
      table.row(1).size = 11
    end

    header_column_widths = [@document_width * 2 / 3, @document_width * 1 / 3]
    header_title_data = [['Users Summary NetBook']]
    header_title_options = {
      column_widths: [@document_width],
      row_colors: ['EDEFF5'],
      cell_style: {
        border_width: 0,
        padding: [15, 12, 1, 20],
        size: 20,
        font: 'montserrat',
        font_style: :bold
      }
    }

    header_logo_data = [[header_table, { image: LOGO_IMG_PATH, position: :center, scale: 0.4 }]]
    header_logo_options = {
      column_widths: header_column_widths,
      row_colors: ['EDEFF5'],
      cell_style: {
        border_width: 2,
        padding: [15, 15],
        borders: [:top],
        border_color: 'c9ced5'
      }
    }

    @pdf.table(header_title_data, header_title_options)
    @pdf.table(header_logo_data, header_logo_options)
  end

  def mid_section
    mid_section_data = [['General', '', ''], ['Start time:', 'End Time:', 'Executed by:'],
              ["Apr 7, 2020", '15m 9s', "#{@email_initializer}"]]
   
    mid_section_options = {
     width: @document_width,
     row_colors: ['ffffff'],
     cell_style: {
      border_width: 0,
      borders: [:bottom],
      border_color: 'c9ced5',
      padding: [10, 15],
      font: 'montserrat',
     }
    }
   
    @pdf.table(mid_section_data, mid_section_options) do |table|
     table.row(0).border_width = 0.5
     table.row(1).text_color = '888892'
     table.row(0).padding = [10, 15]
     table.row(2).size = 11
    end
  end

  def result_section
    # Construir encabezado de la tabla
    report_data = [
      ['#', 'Name', 'Email', 'Role', 'Status']
    ]
  
    # Agregar una fila por cada usuario
    @user_data.each do |user|
      report_data << [
        user.id,         
        user.name,         
        user.email,        
        user.role,        
        user.status           
      ]
    end
  
    # Opciones de la tabla
    report_data_options = {
      width: @document_width,
      row_colors: ['ffffff'],
      cell_style: {
        border_width: 1,
        borders: [:bottom],
        border_color: 'c9ced5',
        padding: [5, 10],
        font: 'montserrat'
      }
    }
  
   
    @pdf.table(report_data, report_data_options) do |table|
   
     table.row(0).text_color = '2787c4'
     table.row(0..-1).padding = [10, 10]
     table.row(0).font_style = :bold
    end
  end
end
