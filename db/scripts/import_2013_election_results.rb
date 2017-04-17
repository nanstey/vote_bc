require 'roo'
require 'pry'

xlsx = Roo::Spreadsheet.open('../excel/2013GE-Results-Excel.xlsx')
xlsx = Roo::Excelx.new("../excel/2013GE-Results-Excel.xlsx")

pp candidates_2017.info