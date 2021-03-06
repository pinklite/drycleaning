object dmClothes: TdmClothes
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 446
  Width = 656
  object sqldsClothesTypes: TSQLDataSet
    CommandText = 
      'select ID, TITLE, ORDER_NO '#13#10'from CLOTHES_TYPES '#13#10'order by ORDER' +
      '_NO'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.sqlconFirebird
    Left = 144
    Top = 64
  end
  object prvClothesTypes: TDataSetProvider
    DataSet = sqldsClothesTypes
    UpdateMode = upWhereKeyOnly
    Left = 144
    Top = 112
  end
  object cdsClothesTypes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prvClothesTypes'
    BeforePost = cdsClothesTypesBeforePost
    AfterPost = cdsClothesTypesAfterPost
    Left = 144
    Top = 160
    object cdsClothesTypesID: TLargeintField
      FieldName = 'ID'
      Required = True
    end
    object cdsClothesTypesTITLE: TWideStringField
      FieldName = 'TITLE'
      Size = 256
    end
    object cdsClothesTypesORDER_NO: TSmallintField
      FieldName = 'ORDER_NO'
    end
  end
  object sqldsClothes: TSQLDataSet
    CommandText = 'select ID, SN, TYPE_ID, REGTM, UPDTM from CLOTHES'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.sqlconFirebird
    Left = 280
    Top = 64
  end
  object prvClothes: TDataSetProvider
    DataSet = sqldsClothes
    UpdateMode = upWhereKeyOnly
    Left = 280
    Top = 112
  end
  object cdsClothes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prvClothes'
    BeforePost = cdsClothesBeforePost
    AfterPost = cdsClothesAfterPost
    Left = 280
    Top = 160
  end
end
