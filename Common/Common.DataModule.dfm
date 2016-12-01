object DataModule4: TDataModule4
  OldCreateOrder = False
  Height = 373
  Width = 450
  object prv1: TDataSetProvider
    DataSet = sqlds1
    Left = 208
    Top = 168
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prv1'
    Left = 208
    Top = 224
  end
  object sqlds1: TSQLDataSet
    Params = <>
    Left = 208
    Top = 112
  end
end
