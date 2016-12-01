object dmEmployees: TdmEmployees
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 283
  Width = 278
  object sqldsEmployees: TSQLDataSet
    CommandText = 
      'select ID, FIRSTNAME, MIDDLENAME, LASTNAME, BIRTHDAY, DEPARMENT_' +
      'ID, IS_ACTIVE, UPDTM, REGTM, USER_ID from EMPLOYEES'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.sqlconFirebird
    Left = 112
    Top = 40
  end
  object prvEmployees: TDataSetProvider
    DataSet = sqldsEmployees
    Left = 112
    Top = 88
  end
  object cdsEmployees: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prvEmployees'
    BeforePost = cdsEmployeesBeforePost
    AfterPost = cdsEmployeesAfterPost
    Left = 112
    Top = 136
  end
  object srcEmployees: TDataSource
    DataSet = cdsEmployees
    Left = 112
    Top = 184
  end
end
