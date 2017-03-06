object CrowdAnnotationForm: TCrowdAnnotationForm
  Left = 0
  Top = 0
  Caption = 'Crowd Annotation Tool'
  ClientHeight = 466
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 938
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelTop'
    ShowCaption = False
    TabOrder = 0
    Visible = False
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 35
    Width = 89
    Height = 390
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'PanelLeft'
    ShowCaption = False
    TabOrder = 1
    object ButtonOpenImage: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 83
      Height = 30
      Action = ImageOpen
      Align = alTop
      TabOrder = 0
    end
    object ButtonSave: TButton
      AlignWithMargins = True
      Left = 3
      Top = 39
      Width = 83
      Height = 30
      Action = ActionSaveCurrentAnnotation
      Align = alTop
      TabOrder = 1
    end
    object ButtonSaveAll: TButton
      AlignWithMargins = True
      Left = 3
      Top = 75
      Width = 83
      Height = 30
      Action = ActionSaveAllAnnotations
      Align = alTop
      TabOrder = 2
    end
    object ButtonClearMarkers: TButton
      AlignWithMargins = True
      Left = 3
      Top = 111
      Width = 83
      Height = 30
      Action = ActionClearMarkers
      Align = alTop
      TabOrder = 3
    end
  end
  object PanelCenter: TPanel
    Left = 89
    Top = 35
    Width = 647
    Height = 390
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object GridPanelCenterBottom: TGridPanel
      Left = 0
      Top = 352
      Width = 647
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'GridPanelCenterBottom'
      ColumnCollection = <
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = ButtonPrevImage
          Row = 0
        end
        item
          Column = 3
          Control = ButtonNextImage
          Row = 0
        end
        item
          Column = 2
          Control = LabelImageCount
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      ShowCaption = False
      TabOrder = 0
      object ButtonPrevImage: TButton
        AlignWithMargins = True
        Left = 132
        Top = 3
        Width = 123
        Height = 32
        Action = ActionPreviousImage
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsStrikeOut]
        ParentFont = False
        TabOrder = 0
      end
      object ButtonNextImage: TButton
        AlignWithMargins = True
        Left = 390
        Top = 3
        Width = 123
        Height = 32
        Action = ActionNextImage
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsStrikeOut]
        ParentFont = False
        TabOrder = 1
      end
      object LabelImageCount: TLabel
        AlignWithMargins = True
        Left = 261
        Top = 3
        Width = 123
        Height = 32
        Align = alClient
        Alignment = taCenter
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object GridPanelCenterTop: TGridPanel
      Left = 0
      Top = 0
      Width = 647
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'GridPanelCenterTop'
      ColumnCollection = <
        item
          Value = 12.500000000000000000
        end
        item
          Value = 12.500000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          Value = 12.500000000000000000
        end
        item
          Value = 12.500000000000000000
        end>
      ControlCollection = <
        item
          Column = 2
          Control = LabelCurrentImageFullName
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      ShowCaption = False
      TabOrder = 1
      object LabelCurrentImageFullName: TLabel
        AlignWithMargins = True
        Left = 163
        Top = 3
        Width = 317
        Height = 14
        Align = alClient
        Alignment = taCenter
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object PanelImageContainer: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 23
      Width = 641
      Height = 326
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Open an image'
      Color = clAppWorkSpace
      ParentBackground = False
      TabOrder = 2
      ExplicitLeft = 352
      ExplicitTop = 168
      ExplicitWidth = 185
      ExplicitHeight = 41
      object ImageContainer: TImage
        Left = 0
        Top = 0
        Width = 641
        Height = 326
        Cursor = crCross
        Align = alClient
        Center = True
        Proportional = True
        OnMouseDown = ImageContainer_MouseDown
        ExplicitLeft = 400
        ExplicitTop = 160
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
  object PanelRight: TPanel
    Left = 736
    Top = 35
    Width = 202
    Height = 390
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    object LabelMarkersCaption: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 83
      Width = 196
      Height = 13
      Align = alTop
      Caption = 'Markers'
      ExplicitWidth = 38
    end
    object GridMarkers: TStringGrid
      Left = 0
      Top = 99
      Width = 202
      Height = 291
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ColCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 0
      ColWidths = (
        64
        64
        64)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object PanelImageInfo: TPanel
      Left = 0
      Top = 0
      Width = 202
      Height = 80
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelImageInfo'
      ShowCaption = False
      TabOrder = 1
      object PanelCaptions: TPanel
        Left = 0
        Top = 0
        Width = 49
        Height = 80
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'PanelCaptions'
        ShowCaption = False
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 41
          Width = 43
          Height = 13
          Align = alTop
          Caption = 'Height'
          ExplicitWidth = 31
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 43
          Height = 13
          Align = alTop
          Caption = 'Name'
          ExplicitWidth = 27
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 43
          Height = 13
          Align = alTop
          Caption = 'Width'
          ExplicitWidth = 28
        end
      end
      object PanelValues: TPanel
        Left = 49
        Top = 0
        Width = 153
        Height = 80
        Align = alClient
        BevelOuter = bvNone
        Caption = 'PanelValues'
        ShowCaption = False
        TabOrder = 1
        object LabelImageHeight: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 41
          Width = 147
          Height = 13
          Align = alTop
          ExplicitWidth = 3
        end
        object LabelImageWidth: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 147
          Height = 13
          Align = alTop
          ExplicitWidth = 3
        end
        object LabelImageName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 147
          Height = 13
          Align = alTop
          ExplicitWidth = 3
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 425
    Width = 938
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    Visible = False
  end
  object ActionList: TActionList
    Left = 281
    Top = 211
    object ImageOpen: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.Filter = 'Images|*.jpg;*.jpeg;*.png;*.PNG;*.bmp'
      Dialog.Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = ImageOpenAccept
    end
    object ActionToggleMarkers: TAction
      Caption = 'Toggle Markers'
    end
    object ActionSaveCurrentAnnotation: TAction
      Caption = 'Save'
      ShortCut = 16467
      OnExecute = ActionSaveCurrentAnnotationExecute
    end
    object ActionPreviousImage: TAction
      Caption = '<--'
      OnExecute = ActionPreviousImageExecute
    end
    object ActionNextImage: TAction
      Caption = '-->'
      OnExecute = ActionNextImageExecute
    end
    object ActionSaveAllAnnotations: TAction
      Caption = 'Save all'
      OnExecute = ActionSaveAllAnnotationsExecute
    end
    object ActionClearMarkers: TAction
      Caption = 'Clear markers'
      OnExecute = ActionClearMarkersExecute
    end
  end
end
