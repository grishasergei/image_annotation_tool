object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 134
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelDotMarker: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 134
    Align = alClient
    Caption = 'PanelDotMarker'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 112
    ExplicitTop = 152
    ExplicitWidth = 497
    ExplicitHeight = 177
    object LabelDotMarker: TLabel
      Left = 6
      Top = 4
      Width = 73
      Height = 16
      Caption = 'Dot Marker'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelDotMarkerColor: TLabel
      Left = 16
      Top = 34
      Width = 25
      Height = 13
      Caption = 'Color'
    end
    object LabelDotMarkerStrokeLength: TLabel
      Left = 16
      Top = 90
      Width = 64
      Height = 13
      Caption = 'Stroke length'
    end
    object LabelDotMarkerStrokeWidth: TLabel
      Left = 16
      Top = 62
      Width = 60
      Height = 13
      Caption = 'Stroke width'
    end
    object EditDotMarkerColor: TColorBox
      Left = 104
      Top = 31
      Width = 145
      Height = 22
      TabOrder = 0
    end
    object EditDotMarkerStrokeWidth: TSpinEdit
      Left = 104
      Top = 59
      Width = 145
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object EditDotMarkerStrokeLength: TSpinEdit
      Left = 104
      Top = 87
      Width = 145
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
  end
  object ActionList: TActionList
    Left = 184
    object ActionShowSettings: TAction
      Caption = 'Show Settings'
      OnExecute = ActionShowSettingsExecute
    end
  end
end
