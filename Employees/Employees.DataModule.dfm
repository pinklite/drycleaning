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
    AfterPost = cdsEmployeesAfterPost
    Left = 112
    Top = 136
    object cdsEmployeesID: TLargeintField
      FieldName = 'ID'
      Required = True
    end
    object cdsEmployeesFIRSTNAME: TWideStringField
      FieldName = 'FIRSTNAME'
      Size = 256
    end
    object cdsEmployeesMIDDLENAME: TWideStringField
      FieldName = 'MIDDLENAME'
      Size = 256
    end
    object cdsEmployeesLASTNAME: TWideStringField
      FieldName = 'LASTNAME'
      Size = 256
    end
    object cdsEmployeesBIRTHDAY: TDateField
      FieldName = 'BIRTHDAY'
    end
    object cdsEmployeesDEPARMENT_ID: TLargeintField
      FieldName = 'DEPARMENT_ID'
    end
    object cdsEmployeesIS_ACTIVE: TSmallintField
      FieldName = 'IS_ACTIVE'
    end
    object sqltmstmpfldEmployeesUPDTM: TSQLTimeStampField
      FieldName = 'UPDTM'
    end
    object sqltmstmpfldEmployeesREGTM: TSQLTimeStampField
      FieldName = 'REGTM'
    end
    object cdsEmployeesUSER_ID: TLargeintField
      FieldName = 'USER_ID'
    end
  end
  object srcEmployees: TDataSource
    DataSet = cdsEmployees
    Left = 112
    Top = 184
  end
end
