USE [YYLink]
GO
/****** Object:  UserDefinedFunction [dbo].[f_GetPy]    Script Date: 2017-01-08 3:34:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery6.sql|7|0|C:\Users\sysname\AppData\Local\Temp\1\~vsD397.sql

-- 引用前辈们的一个函数 --
CREATE function [dbo].[f_GetPy](@input nvarchar(4000))
returns nvarchar(4000)
as
begin
-- declare @input nvarchar(4000)
-- set @input ='Google'
declare @length int, @substr nchar(1), @PY nvarchar(4000)
declare @t table(chr nchar(1) collate Chinese_PRC_CI_AS, letter nchar(1))
insert into @t(chr, letter)
	select '0','L' union all select '1','Y' union all
	select '2','E' union all select '3','S' union all
	select '4','S' union all select '5','W' union all
	select '6','L' union all select '7','Q' union all
	select '8','B' union all select '9','J' union all
	select N'吖','A' union all select N'八','B' union all
	select N'嚓','C' union all select N'咑','D' union all
	select N'妸','E' union all select N'发','F' union all
	select N'旮','G' union all select N'铪','H' union all
	select N'丌','J' union all select N'咔','K' union all
	select N'垃','L' union all select N'嘸','M' union all
	select N'拏','N' union all select N'噢','O' union all
	select N'妑','P' union all select N'七','Q' union all
	select N'呥','R' union all select N'仨','S' union all
	select N'他','T' union all select N'屲','W' union all
	select N'夕','X' union all select N'丫','Y' union all
	select N'帀','Z'
	
	-- select * from @t order by chr desc
    set @length = len(@input)
    set @PY = ''
    
    while @length > 0
    begin
		set @substr = substring(@input,@length,1)
		-- 非汉字字符或数字，返回原字符
		set @PY=(case when unicode(@substr) between 19968 and 40869 or unicode(@substr) between 48 and 57
		then (select top 1 letter from @t where chr <= @substr order by chr desc)
		else @substr
		end)+@PY
		set @length = @length - 1
        /* select top 1 @PY = letter+@PY, @strlen = @length-1
            from @t a where chr <= @substr
            order by chr desc
        if @@rowcount = 0 or (unicode(@input) between 58 and 19967)
            select @PY = substring(@input,@length,1)+@PY, @length = @length-1 */
    end
    return(@PY)
end 



GO
/****** Object:  UserDefinedFunction [dbo].[f_GetPy2]    Script Date: 2017-01-08 3:34:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  function [dbo].[f_GetPy2](@str nvarchar(4000))   
returns nvarchar(4000)   
as   
begin   
declare @word nchar(1),@PY nvarchar(4000)   
set @PY=''   
while len(@str)>0   
begin   
set @word=left(@str,1)   
--如果非汉字字符，返回原字符
set @PY=@PY+(case when unicode(@word) between 19968 and 19968+20901 or unicode(@word) between 48 and 57
then (select top 1 PY from (   
select 'A' as PY,N'驁' as word   
union all select 'B',N'簿'   union all select 'C',N'錯'   
union all select 'D',N'鵽'   union all select 'E',N'樲'   
union all select 'F',N'鰒'   union all select 'G',N'腂'   
union all select 'H',N'夻'   union all select 'J',N'攈'   
union all select 'K',N'穒'   union all select 'L',N'鱳'   
union all select 'M',N'旀'   union all select 'N',N'桛'   
union all select 'O',N'漚'   union all select 'P',N'曝'   
union all select 'Q',N'囕'   union all select 'R',N'鶸'   
union all select 'S',N'蜶'   union all select 'T',N'籜'   
union all select 'W',N'鶩'   union all select 'X',N'鑂'   
union all select 'Y',N'韻'   union all select 'Z',N'咗'   
union all select 'L',N'0'   union all select 'Y',N'1'
union all select 'E',N'2'   union all select 'S',N'3'
union all select 'S',N'4'   union all select 'W',N'5'
union all select 'L',N'6'   union all select 'Q',N'7'
union all select 'B',N'8'   union all select 'J',N'9'
) T    
where word>=@word collate Chinese_PRC_CS_AS_KS_WS    
order by word ASC) else @word end)   
set @str=right(@str,len(@str)-1)   
end   
return @PY   
end 


GO
/****** Object:  Table [dbo].[Advertisments]    Script Date: 2017-01-08 3:34:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisments](
	[AdId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AdName] [nvarchar](100) NOT NULL,
	[Price] [int] NULL,
 CONSTRAINT [PK_Advertisments] PRIMARY KEY CLUSTERED 
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bulletins]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bulletins](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[LinkUrl] [nvarchar](200) NOT NULL,
	[Priority] [int] NOT NULL,
	[Established] [datetime] NOT NULL,
	[ValidDate] [datetime] NOT NULL,
	[isEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Bulletins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Channels]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channels](
	[ChannelId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ParentId] [int] NULL,
	[Depth] [int] NULL,
	[MainSiteId] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Type] [int] NULL,
	[Status] [int] NULL,
	[Template] [int] NULL,
	[OutputPath] [nvarchar](100) NULL,
	[CreateTime] [datetime] NULL,
	[CreateUser] [nvarchar](100) NULL,
	[OperateTime] [datetime] NULL,
	[OperateUser] [nvarchar](100) NULL,
	[Priority] [int] NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[NavigateUrl] [nvarchar](250) NULL,
	[UrlTarget] [nvarchar](10) NULL,
	[LanguageId] [int] NULL,
	[TotalSubjects] [int] NULL,
	[IsApproved] [bit] NULL,
	[Attribute] [xml] NULL,
 CONSTRAINT [PK_Channels] PRIMARY KEY CLUSTERED 
(
	[ChannelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Images]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[ImageId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SiteId] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[WxH] [nvarchar](10) NOT NULL,
	[Type] [int] NOT NULL,
	[Size] [int] NOT NULL,
	[Path] [nvarchar](200) NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Links]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Links](
	[LinkId] [int] IDENTITY(2500,1) NOT FOR REPLICATION NOT NULL,
	[SiteId] [int] NOT NULL,
	[Href] [nvarchar](200) NOT NULL,
	[Type] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
	[Priority] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Links] PRIMARY KEY CLUSTERED 
(
	[LinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sites]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sites](
	[SiteId] [int] IDENTITY(1100,1) NOT FOR REPLICATION NOT NULL,
	[ChannelId] [int] NOT NULL,
	[SiteName] [nvarchar](100) NOT NULL,
	[FirstCapital] [nvarchar](1) NOT NULL,
	[Priority] [int] NOT NULL,
	[Grade] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[Style] [nvarchar](100) NOT NULL,
	[Established] [datetime] NOT NULL,
	[Specification] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Icon] [nvarchar](100) NOT NULL,
	[Thumb] [nvarchar](100) NOT NULL,
	[AgentUrl] [nvarchar](200) NOT NULL,
	[JsRedirect] [bit] NOT NULL,
 CONSTRAINT [PK_Sites] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[synTest]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[synTest](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[data] [nvarchar](20) NOT NULL,
	[createTime] [datetime] NOT NULL,
 CONSTRAINT [PK_synTest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
 CONSTRAINT [PK__sysdiagr__C2B05B61060DEAE8] PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Test]    Script Date: 2017-01-08 3:34:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[data] [nvarchar](20) NOT NULL,
	[createTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
