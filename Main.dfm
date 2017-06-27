object CrowdAnnotationForm: TCrowdAnnotationForm
  Left = 0
  Top = 0
  Caption = 'Crowd Annotation Tool'
  ClientHeight = 547
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 966
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelTop'
    ShowCaption = False
    TabOrder = 0
    Visible = False
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 966
      Height = 29
      ButtonHeight = 21
      Caption = 'ToolBar1'
      Menu = MainMenu
      ShowCaptions = True
      TabOrder = 0
    end
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 35
    Width = 89
    Height = 471
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
      Top = 75
      Width = 83
      Height = 30
      Action = ActionSaveCurrentAnnotation
      Align = alTop
      TabOrder = 1
    end
    object ButtonSaveAll: TButton
      AlignWithMargins = True
      Left = 3
      Top = 111
      Width = 83
      Height = 30
      Action = ActionSaveAllAnnotations
      Align = alTop
      TabOrder = 2
    end
    object ButtonClearMarkers: TButton
      AlignWithMargins = True
      Left = 3
      Top = 147
      Width = 83
      Height = 30
      Action = ActionClearMarkers
      Align = alTop
      TabOrder = 3
    end
    object ButtonLoadAnnotations: TButton
      AlignWithMargins = True
      Left = 3
      Top = 39
      Width = 83
      Height = 30
      Action = ActionLoadAnnotations
      Align = alTop
      TabOrder = 4
    end
  end
  object PanelCenter: TPanel
    Left = 89
    Top = 35
    Width = 675
    Height = 471
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object GridPanelCenterBottom: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 430
      Width = 669
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
      ParentBackground = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      ShowCaption = False
      TabOrder = 0
      object ButtonPrevImage: TButton
        AlignWithMargins = True
        Left = 136
        Top = 3
        Width = 127
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
        Left = 402
        Top = 3
        Width = 127
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
        Left = 269
        Top = 3
        Width = 127
        Height = 32
        Align = alClient
        Alignment = taCenter
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object GridPanelCenterTop: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 669
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'GridPanelCenterTop'
      Color = clAppWorkSpace
      ColumnCollection = <
        item
          Value = 25.000000000000000000
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
          Column = 1
          Control = LabelCurrentImageFullName
          Row = 0
        end
        item
          Column = 0
          Control = PanelModeButtons
          Row = 0
        end
        item
          Column = 3
          Control = ButtonCloseCurrentImage
          Row = 0
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      ShowCaption = False
      TabOrder = 1
      object LabelCurrentImageFullName: TLabel
        AlignWithMargins = True
        Left = 170
        Top = 3
        Width = 328
        Height = 19
        Align = alClient
        Alignment = taCenter
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object PanelModeButtons: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 167
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        Caption = 'PanelModeButtons'
        ShowCaption = False
        TabOrder = 0
        object ButtonCombinedMode: TSpeedButton
          AlignWithMargins = True
          Left = 1
          Top = 3
          Width = 53
          Height = 19
          Margins.Left = 1
          Margins.Right = 1
          Action = ActionPresentationModeCombined
          Align = alLeft
          Down = True
        end
        object ButtonMaskMode: TSpeedButton
          AlignWithMargins = True
          Left = 111
          Top = 3
          Width = 53
          Height = 19
          Margins.Left = 1
          Margins.Right = 1
          Action = ActionPresentationModeMask
          Align = alLeft
        end
        object ButtonOriginalMode: TSpeedButton
          AlignWithMargins = True
          Left = 56
          Top = 3
          Width = 53
          Height = 19
          Margins.Left = 1
          Margins.Right = 1
          Action = ActionPresentationModeOriginal
          Align = alLeft
        end
      end
      object ButtonCloseCurrentImage: TButton
        AlignWithMargins = True
        Left = 626
        Top = 3
        Width = 40
        Height = 19
        Action = ActionCloseCurrentImage
        Align = alRight
        TabOrder = 1
      end
    end
    object PanelImageContainer: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 669
      Height = 390
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Open an image'
      Color = clAppWorkSpace
      ParentBackground = False
      TabOrder = 2
      object ImageContainer: TImage
        Left = 0
        Top = 0
        Width = 669
        Height = 390
        Cursor = crCross
        Align = alClient
        Center = True
        Proportional = True
        ExplicitLeft = 400
        ExplicitTop = 160
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
      object PanelMagnifier: TPanel
        Left = 376
        Top = 224
        Width = 145
        Height = 97
        BevelOuter = bvNone
        Caption = 'PanelMagnifier'
        Color = clHighlight
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
        Visible = False
        object ImageMagnifier: TImage
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 145
          Height = 97
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Center = True
          Proportional = True
          Stretch = True
          ExplicitLeft = 32
          ExplicitTop = 24
          ExplicitWidth = 110
          ExplicitHeight = 70
        end
      end
    end
  end
  object PanelRight: TPanel
    Left = 764
    Top = 35
    Width = 202
    Height = 471
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    object LabelHistoryCaption: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 224
      Width = 196
      Height = 13
      Align = alTop
      Caption = 'Edit History'
      ExplicitWidth = 55
    end
    object PanelImageInfo: TPanel
      Left = 0
      Top = 141
      Width = 202
      Height = 80
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelImageInfo'
      ShowCaption = False
      TabOrder = 0
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
    object ListBoxHistory: TListBox
      AlignWithMargins = True
      Left = 3
      Top = 243
      Width = 196
      Height = 225
      Style = lbOwnerDrawFixed
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      TabOrder = 1
      OnDrawItem = ListBoxHistoryDrawItem
    end
    object PanelZoomBox: TPanel
      Left = 0
      Top = 0
      Width = 202
      Height = 141
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelZoomBox'
      ShowCaption = False
      TabOrder = 2
      object ImageZoomBox: TImage
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 196
        Height = 106
        Align = alClient
        Center = True
        Proportional = True
        Stretch = True
        ExplicitHeight = 118
      end
      object TrackBarZoomFactor: TTrackBar
        Left = 0
        Top = 112
        Width = 202
        Height = 29
        Align = alBottom
        Min = 1
        ParentShowHint = False
        Position = 2
        PositionToolTip = ptBottom
        ShowHint = False
        TabOrder = 0
        TickStyle = tsNone
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 506
    Width = 966
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
    end
    object ActionPreviousImage: TAction
      Caption = '<--'
    end
    object ActionNextImage: TAction
      Caption = '-->'
    end
    object ActionSaveAllAnnotations: TAction
      Caption = 'Save all'
    end
    object ActionClearMarkers: TAction
      Caption = 'Clear markers'
    end
    object ActionPresentationModeCombined: TAction
      Caption = 'Combined'
    end
    object ActionPresentationModeOriginal: TAction
      Caption = 'Original'
    end
    object ActionPresentationModeMask: TAction
      Caption = 'Mask'
    end
    object ActionCloseCurrentImage: TAction
      Caption = 'Close'
    end
    object ActionLoadAnnotations: TFileOpen
      Category = 'File'
      Caption = 'Annotations...'
      Dialog.Filter = 'JSON|*.txt'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
    end
    object ActionZoomFactorChange: TAction
      Caption = 'ActionZoomFactorChange'
    end
    object ActionShowSettings: TAction
      Caption = 'Settings'
    end
  end
  object MainMenu: TMainMenu
    Left = 24
    Top = 251
    object Settings1: TMenuItem
      Caption = 'File'
      object Settings2: TMenuItem
        Action = ActionShowSettings
      end
    end
  end
end
