object dm: Tdm
  OldCreateOrder = False
  Height = 113
  Width = 168
  object connec: TFDConnection
    ConnectionName = 'proj_wk'
    Params.Strings = (
      'Database=proj_wk'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 32
  end
  object driver_link: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\bruno\Documents\Embarcadero\Studio\Projects\WK\Codigo\d' +
      'll\libmysql.dll'
    Left = 80
    Top = 32
  end
end
