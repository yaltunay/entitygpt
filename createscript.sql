USE [master]
GO
/****** Object:  Database [SARDUNYADBNEW]    Script Date: 30.05.2024 17:22:52 ******/
CREATE DATABASE [SARDUNYADBNEW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NetAuditDB', FILENAME = N'/var/opt/mssql/data/SARDUNYADBNEW.mdf' , SIZE = 1684416KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NetAuditDB_log', FILENAME = N'/var/opt/mssql/data/SARDUNYADBNEW_0.ldf' , SIZE = 27323008KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE Turkish_CI_AS
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SARDUNYADBNEW] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SARDUNYADBNEW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SARDUNYADBNEW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET ARITHABORT OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SARDUNYADBNEW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SARDUNYADBNEW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SARDUNYADBNEW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SARDUNYADBNEW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET RECOVERY FULL 
GO
ALTER DATABASE [SARDUNYADBNEW] SET  MULTI_USER 
GO
ALTER DATABASE [SARDUNYADBNEW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SARDUNYADBNEW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SARDUNYADBNEW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SARDUNYADBNEW] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SARDUNYADBNEW] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SARDUNYADBNEW] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SARDUNYADBNEW', N'ON'
GO
ALTER DATABASE [SARDUNYADBNEW] SET QUERY_STORE = OFF
GO
USE [SARDUNYADBNEW]
GO
/****** Object:  User [sardunyaaudit]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [sardunyaaudit] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [hkyaudit]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [hkyaudit] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gayar]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [gayar] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [eozmaskan]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [eozmaskan] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ecinar]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [ecinar] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dgirginer]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [dgirginer] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [DENETIMSQL\NetaxTech]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [DENETIMSQL\NetaxTech] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [DENETIMSQL\Administrator]    Script Date: 30.05.2024 17:22:52 ******/
CREATE USER [DENETIMSQL\Administrator] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sardunyaaudit]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [sardunyaaudit]
GO
ALTER ROLE [db_datareader] ADD MEMBER [gayar]
GO
ALTER ROLE [db_owner] ADD MEMBER [eozmaskan]
GO
ALTER ROLE [db_owner] ADD MEMBER [ecinar]
GO
ALTER ROLE [db_owner] ADD MEMBER [dgirginer]
GO
ALTER ROLE [db_owner] ADD MEMBER [DENETIMSQL\NetaxTech]
GO
ALTER ROLE [db_owner] ADD MEMBER [DENETIMSQL\Administrator]
GO
/****** Object:  Schema [HangFire]    Script Date: 30.05.2024 17:22:52 ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  UserDefinedFunction [dbo].[F_LocationAverageAuditResult]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_LocationAverageAuditResult]
(
@locationID int

)
RETURNS nvarchar(50) --döndürecegi degerin tipi
AS
BEGIN
  DECLARE @averagePoint nvarchar(50)
  
select @averagePoint=avg(rl.TotalPoint) from TblAuditRealize as rl inner join TblAuditPlan as pl on rl.AuditPlanID=pl.AuditPlanID where pl.LocationID=@locationID
 
RETURN(@averagePoint)
END


--select dbo.F_LocationAverageAuditResult(849)
GO
/****** Object:  UserDefinedFunction [dbo].[FN_COALESCEAuditorTypeDetailList]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION   [dbo].[FN_COALESCEAuditorTypeDetailList](@Id INT)

RETURNS NVARCHAR(MAX)
AS
BEGIN

	-- Declare the return variable here
DECLARE @combinedString VARCHAR(MAX)

--select dbo.FUNC_COALESCE(8)
	-- Add the T-SQL statements to compute the return value here
SELECT @combinedString = COALESCE(@combinedString + '-', '')+ td.TypeName
FROM 
TblAuditor as au, TblExpert as ex, TblAuditLocations as al, TblTypeDetail as td
WHERE  au.ExpertID=ex.ExpertID and al.ExpertID=ex.ExpertID and al.LocationTypeID=td.TypeDetailId and au.AuditorID=@Id


	-- Return the result of the function
	RETURN  @combinedString;

END






GO
/****** Object:  UserDefinedFunction [dbo].[FN_HandAndDeviceUnCorrectiveCount]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_HandAndDeviceUnCorrectiveCount](@AuditPlanID int) RETURNS INTEGER

AS
BEGIN
   

DECLARE @Total int=0
DECLARE @TotalHand int=0
DECLARE @TotalDevice int=0
DECLARE @TotalHandAndDeviceCorrectiveCount int=0

--SET @TotalHandAndDeviceCorrectiveCount=(select COUNT(*) from TblHandAndDeviceCorrective WHERE AuditPlanID=@AuditPlanID)
--IF @TotalHandAndDeviceCorrectiveCount>1
--	BEGIN
--	SET @TotalHand=  (select COUNT(*) from TblAuditedHands as hand inner join TblHandAndDeviceCorrective as corrective on  hand.AuditedHandID=corrective.AuditedHandID where hand.AuditPlanID=@AuditPlanID and corrective.ConfirmDate is null and hand.Explanation2='UYGUN D.')
--	SET @TotalDevice=    (select COUNT(*) from TblAuditedDevice as device inner join TblHandAndDeviceCorrective as corrective on  device.AuditedDeviceID=corrective.AuditedDeviceID where device.AuditPlanID=@AuditPlanID and corrective.ConfirmDate is null  and (device.Result1 < 0 or device.Result1 >= 200))

--	SET @Total=@TotalHand+@TotalDevice
--END
--ELSE IF (@TotalHandAndDeviceCorrectiveCount = 1)
--	BEGIN	
--	SET  @Total=1
	
--END
--   RETURN @Total
--END
SET @TotalHand=  (select COUNT(*) from TblAuditedHands as hand inner join TblHandAndDeviceCorrective as corrective on  hand.AuditedHandID=corrective.AuditedHandID where hand.AuditPlanID=@AuditPlanID and corrective.ConfirmDate is null and hand.Explanation2='UYGUN D.')
SET @TotalDevice=    (select COUNT(*) from TblAuditedDevice as device inner join TblHandAndDeviceCorrective as corrective on  device.AuditedDeviceID=corrective.AuditedDeviceID where device.AuditPlanID=@AuditPlanID and corrective.ConfirmDate is null  and (device.Result1 < 0 or device.Result1 >= 200))

SET @Total=@TotalHand+@TotalDevice
RETURN @Total

END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_COALESCEAditPlanList]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION   [dbo].[FUNC_COALESCEAditPlanList](@Id INT)

RETURNS NVARCHAR(MAX)
AS
BEGIN

	-- Declare the return variable here
DECLARE @combinedString VARCHAR(MAX)

--select dbo.FUNC_COALESCE(8)
	-- Add the T-SQL statements to compute the return value here
SELECT @combinedString = COALESCE(@combinedString + '-', '')+ me.MeasName
FROM 
 TblMeasurement as me, TblAuditMeasurePlan as amp 
WHERE  amp.MeasurementID=me.MeasurementID and amp.AuditPlanID=@Id


	-- Return the result of the function
	RETURN  @combinedString;

END






GO
/****** Object:  Table [dbo].[TblAudit]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAudit](
	[AuditID] [int] IDENTITY(1,1) NOT NULL,
	[AuditName] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[RegulationID] [int] NULL,
	[AuditTypeID] [int] NOT NULL,
	[Explanation] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[AuditCode] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__TblAudit__A17F23B89C28F76E] PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblHandAndDeviceCorrective]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblHandAndDeviceCorrective](
	[HandAndDeviceCorrectiveID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ActionExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ActionStatue] [bit] NULL,
	[ConfirmStatue] [bit] NULL,
	[PlanDate] [date] NULL,
	[RealizeDate] [date] NULL,
	[ConfirmDate] [date] NULL,
	[PlanEmployeeID] [int] NULL,
	[RealizeEmployeeID] [int] NULL,
	[RetCount] [int] NULL,
	[IsActive] [bit] NULL,
	[AuditedHandID] [int] NULL,
	[AuditedDeviceID] [int] NULL,
 CONSTRAINT [PK_TblHandAndDeviceCorrective] PRIMARY KEY CLUSTERED 
(
	[HandAndDeviceCorrectiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocation](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[LocationTypeID] [int] NULL,
	[ContactID] [int] NULL,
	[RegionID] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[SignatureCode] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[ExplanationInfo] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[EatingNumber] [int] NULL,
 CONSTRAINT [PK_TblLocations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditPlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditPlan](
	[AuditPlanID] [int] IDENTITY(1,1) NOT NULL,
	[PlanName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[LocationID] [int] NULL,
	[DepartmentID] [int] NULL,
	[AuditDate] [datetime] NOT NULL,
	[IsAudited] [bit] NULL,
	[IsApproved] [bit] NULL,
	[PlannerID] [int] NULL,
	[AuditTypeID] [int] NULL,
	[QuesSetTypeID] [int] NULL,
	[ProviderID] [int] NULL,
	[AuditID] [int] NULL,
	[PeriodID] [int] NOT NULL,
	[ProductCatID] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[AuditorCount] [int] NULL,
	[AuditOHS] [bit] NULL,
	[ConfirmDate] [date] NULL,
	[ConfirmEmployeeID] [int] NULL,
	[InspectionCover] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[InspectionReportNumber] [int] NULL,
 CONSTRAINT [PK__TblAudit__D669CFA933FFF711] PRIMARY KEY CLUSTERED 
(
	[AuditPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditorAuditPlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditorAuditPlan](
	[AuditorAuditPlanID] [int] IDENTITY(1,1) NOT NULL,
	[AuditorID] [int] NOT NULL,
	[AuditPlanID] [int] NOT NULL,
	[IsRealized] [bit] NULL,
	[AuditDate] [date] NULL,
	[IsConfirmAuth] [bit] NULL,
	[IsConfirmToken] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[AuditorExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ManagerExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[AuditTrackingExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SignatureImage] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Statue] [bit] NULL,
	[AuditedExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[AuditRealizedAuthName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[AuditRealizedAuthId] [int] NULL,
	[IsCompleted] [bit] NULL,
 CONSTRAINT [PK_TblAuditorAuditPlan] PRIMARY KEY CLUSTERED 
(
	[AuditorAuditPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditRealize]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditRealize](
	[AuditRealizeID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[AuditDate] [date] NULL,
	[TotalPoint] [float] NULL,
	[LocationID] [int] NULL,
	[TotalProcessPoint] [float] NULL,
	[TotalTechPoint] [float] NULL,
	[TotalInfraPoint] [float] NULL,
	[HandSamplePoint] [float] NULL,
	[ItemSamplePoint] [float] NULL,
	[MajorPoint] [float] NULL,
	[InfraMajorPoint] [float] NULL,
	[TechMajorPoint] [float] NULL,
	[QualityPoint] [float] NULL,
	[QualityTecnic] [float] NULL,
	[QualityInfra] [float] NULL,
	[ManagerExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[UnsuitabilityStatue] [bit] NULL,
	[CorrectiveActivityStatue] [bit] NULL,
	[ProcesTecnicPoint] [float] NULL,
	[ProcesInfraPoint] [float] NULL,
	[QualityProTecnic] [float] NULL,
	[QualityProInfra] [float] NULL,
	[ResultTecnicPoint] [float] NULL,
	[ResultInfraPoint] [float] NULL,
	[IsOpeningActivityCorrective] [bit] NULL,
 CONSTRAINT [PK__TblAudit__1096648EAE46F7B1] PRIMARY KEY CLUSTERED 
(
	[AuditRealizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditRealizeDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditRealizeDetail](
	[AudReDetID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[QuestionID] [int] NULL,
	[ProcessPoint] [float] NULL,
	[TechnicalPoint] [float] NULL,
	[InfrastructurePoint] [float] NULL,
	[ScaleDetailID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsNonAudit] [bit] NULL,
	[LevelID] [int] NULL,
	[AuditorID] [int] NULL,
	[ActionExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsRegulatoryActivity] [bit] NULL,
	[IsContinuEvidence] [bit] NULL,
	[FirstResponsible] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[SecondResponsible] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[ThirdResponsible] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[ActionStatue] [bit] NULL,
	[ConfirmActionStatue] [bit] NULL,
	[RegulationID] [int] NULL,
	[MajorGroupID] [int] NULL,
	[ImgStatue] [bit] NOT NULL,
	[EvidenceIndex] [int] NULL,
	[BrokenType] [int] NULL,
	[MinutesExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblAuditRealizeDetail] PRIMARY KEY CLUSTERED 
(
	[AudReDetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditType](
	[AuditTypeID] [int] IDENTITY(1,1) NOT NULL,
	[AffectPerformance] [bit] NULL,
	[NeedApprove] [bit] NULL,
	[TypeName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
	[IconType] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Color] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TESTVIEW]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_TESTVIEW]
AS
SELECT 
 auditPlan.AuditPlanID AS AuditPlanID,
 auditPlan.AuditDate AS AuditDate,
 auditType.TypeName AS AuditType,
 audit.AuditName AS Audit,
 location.LocationName AS ServiceName,
 auditRealize.UnsuitabilityStatue AS UnsuitabilityStatue
 ,(SELECT COUNT(*) FROM TblAuditRealizeDetail WHERE AuditPlanID = auditPlan.AuditPlanID AND IsRegulatoryActivity = 1 AND ConfirmActionStatue != 1) AS CorrectiveActivityStatue,
 (SELECT COUNT(*) FROM TblHandAndDeviceCorrective WHERE AuditPlanID = auditPlan.AuditPlanID AND (ConfirmStatue = 0 OR ConfirmStatue IS NULL) AND (AuditedHandID IS NOT NULL OR AuditedDeviceID IS NOT NULL)) AS HandAndDevice
FROM
		   TblAuditRealize			AS auditRealize 
INNER JOIN TblAuditPlan				AS auditPlan			on auditRealize.AuditPlanID = auditPlan.AuditPlanID
INNER JOIN TblLocation				AS location				on auditPlan.LocationID = location.LocationID
INNER JOIN TblAuditType				AS auditType			on auditPlan.AuditTypeID = auditType.AuditTypeID
INNER JOIN TblAudit					AS audit				on auditPlan.AuditID = audit.AuditID
INNER JOIN TblAuditorAuditPlan		AS auditorplan			on auditPlan.AuditPlanID = auditorplan.AuditPlanID

GO
/****** Object:  Table [dbo].[TblEmployee]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) COLLATE Turkish_CI_AS NULL,
	[Surname] [varchar](50) COLLATE Turkish_CI_AS NULL,
	[ProfilImageUrl] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[AccountID] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[PositionRoleID] [int] NULL,
	[CertificateID] [int] NULL,
	[DepartmentID] [int] NULL,
	[ContactID] [int] NULL,
 CONSTRAINT [PK_TblEmployee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTypeDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTypeDetail](
	[TypeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NULL,
	[TypeName] [nvarchar](130) COLLATE Turkish_CI_AS NULL,
	[EffectStrength] [float] NULL,
	[AccidentTypeCode] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblTypeDetail] PRIMARY KEY CLUSTERED 
(
	[TypeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTargetType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTargetType](
	[TargetTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TargetTypeName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[TargetTypeCode] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblTargetType] PRIMARY KEY CLUSTERED 
(
	[TargetTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDepartment]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDepartment](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](30) COLLATE Turkish_CI_AS NULL,
	[DepartmentTypeID] [int] NULL,
	[Explantion] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Code] [nvarchar](25) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblDepartment] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTarget]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTarget](
	[TargetID] [int] IDENTITY(1,1) NOT NULL,
	[DoWorkExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[TargetDirection] [int] NULL,
	[StartDate] [datetime] NULL,
	[FinishDate] [datetime] NULL,
	[CurrentValue] [float] NULL,
	[TargetValue] [float] NULL,
	[RealizedValue] [float] NULL,
	[AttentID] [int] NULL,
	[PeriodControl] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Result] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[TargetTypeID] [int] NULL,
	[TargetModulID] [int] NULL,
	[TargetModul] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[TargetCategoryID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__TblTarge__2B1F0FB688C4B561] PRIMARY KEY CLUSTERED 
(
	[TargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TargetList]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_TargetList]
AS
SELECT       
t.TargetID, ty.TypeName AS TargetCategoryName, t.DoWorkExplanation,
t.TargetModul, t.TargetModulID, t.StartDate, t.FinishDate, ttype.TargetTypeName,
t.CurrentValue,t.TargetValue,
CASE ttype.TargetTypeCode
  WHEN 'LocationTarget' THEN loc.LocationName
  WHEN 'EmployeeTarget' THEN  emp.Name+' '+emp.Surname
  WHEN 'DepartmentTarget' THEN dep.DepartmentName
END as TargetResponsible ,
t.TargetModulID as ReponsibleID
FROM            
dbo.TblTarget AS t WITH (NOLOCK) INNER JOIN  dbo.TblTypeDetail AS ty WITH (NOLOCK) ON t.TargetCategoryID = ty.TypeDetailId
LEFT OUTER JOIN dbo.TblTargetType AS ttype WITH (NOLOCK) ON t.TargetTypeID = ttype.TargetTypeID
LEFT OUTER JOIN dbo.TblEmployee AS emp WITH (NOLOCK) ON t.TargetModulID = emp.EmployeeID
LEFT OUTER JOIN dbo.TblDepartment AS dep WITH (NOLOCK) ON t.TargetModulID = dep.DepartmentID 
LEFT OUTER JOIN dbo.TblLocation AS loc WITH (NOLOCK) ON t.TargetModulID = loc.LocationID


GO
/****** Object:  Table [dbo].[TblAppMenu]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppMenu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[ManuName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblAppMenu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppRoleSubMenuItemRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppRoleSubMenuItemRelationship](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[SubMenuItemID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_TblRoleSubMenuItemRelationship] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppSubMenu]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppSubMenu](
	[SubMenuID] [int] IDENTITY(1,1) NOT NULL,
	[SubMenuName] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Explanation] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[IconType] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[SubMenuIndex] [int] NULL,
	[MenuID] [int] NOT NULL,
 CONSTRAINT [PK_TblAppSubMenu] PRIMARY KEY CLUSTERED 
(
	[SubMenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppSubMenuItem]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppSubMenuItem](
	[SubMenuItemID] [int] IDENTITY(1,1) NOT NULL,
	[LinkText] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[ControllerName] [nvarchar](75) COLLATE Turkish_CI_AS NOT NULL,
	[ActionName] [nvarchar](75) COLLATE Turkish_CI_AS NOT NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ShowMenuItem] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TabMenuItemID] [int] NULL,
 CONSTRAINT [PK_TblSubMenuItem] PRIMARY KEY CLUSTERED 
(
	[SubMenuItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppSubMenuItemRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppSubMenuItemRelationship](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[SubMenuID] [int] NOT NULL,
	[SubMenuItemID] [int] NOT NULL,
 CONSTRAINT [PK_TblAppSubMenuItemRelationship] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_MenuInfo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[V_MenuInfo]
AS
SELECT        me.MenuID, me.ManuName AS MenuText, subme.SubMenuID, subme.SubMenuName AS SubMenuText, 
subme.IconType, item.LinkText, item.ControllerName, item.ActionName, 
CASE  WHEN rolitem.RoleID IS NULL THEN 0 ELSE rolitem.RoleID END AS RoleID, 
CASE  WHEN item.SubMEnuItemID IS NULL THEN 0 ELSE item.SubMEnuItemID END AS SubMEnuItemID, 
CASE  WHEN meitemre.InckeyNo IS NULL THEN 0 ELSE meitemre.InckeyNo END AS InckeyNo, 
CASE  WHEN item.ShowMenuItem IS NULL THEN 'True' ELSE item.ShowMenuItem END AS ShowMenuItem

FROM            dbo.TblAppMenu AS me WITH (NOLOCK) INNER JOIN dbo.TblAppSubMenu AS subme WITH (NOLOCK) ON me.MenuID = subme.MenuID 
LEFT OUTER JOIN  dbo.TblAppSubMenuItemRelationship AS meitemre WITH (NOLOCK) ON subme.SubMenuID = meitemre.SubMenuID 
LEFT OUTER JOIN dbo.TblAppSubMenuItem AS item WITH (NOLOCK) ON meitemre.SubMenuItemID = item.SubMenuItemID 
LEFT OUTER JOIN dbo.TblAppRoleSubMenuItemRelationship AS rolitem WITH (NOLOCK) ON item.SubMenuItemID = rolitem.SubMenuItemID




GO
/****** Object:  Table [dbo].[TblContact]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblContact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderID] [int] NULL,
	[ContactName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Longitude] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Latitude] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Address] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[CityID] [int] NULL,
	[TownID] [int] NULL,
	[Email] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[Fax] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Phone] [nvarchar](20) COLLATE Turkish_CI_AS NULL,
	[Mobile] [nvarchar](20) COLLATE Turkish_CI_AS NULL,
	[GeoRegionID] [int] NULL,
	[Country] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[LocationID] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK__TblConta__5C6625BB23EC3073] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUser]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[UserName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Password] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[AuthToken] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[WebAudthToken] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[ResetPasswordToken] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Signuture] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUserMessage]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUserMessage](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[ReceiverUserID] [int] NULL,
	[MessageID] [int] NULL,
	[IsRead] [bit] NULL,
	[IsAnounced] [bit] NULL,
	[SetMessageDate] [datetime] NULL,
	[Trash] [bit] NULL,
 CONSTRAINT [PK_TblUserMessage] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_NotificationAutimaticEmail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[V_NotificationAutimaticEmail]
AS
SELECT    
emp.PositionRoleID,
con.Email, usmess.
ReceiverUserID,
count(usmess.IsAnounced) as AnnounceCount
FROM dbo.TblUserMessage AS usmess WITH (NOLOCK) 
INNER JOIN dbo.TblUser AS us WITH (NOLOCK) ON usmess.ReceiverUserID = us.UserID 
INNER JOIN dbo.TblEmployee AS emp WITH (NOLOCK) ON us.EmployeeID = emp.EmployeeID 
INNER JOIN dbo.TblContact AS con WITH (NOLOCK) ON emp.ContactID = con.ContactID
WHERE        (usmess.IsAnounced = 0) 
GROUP BY usmess.ReceiverUserID, con.Email,emp.PositionRoleID


GO
/****** Object:  Table [dbo].[TblVirtualRegion]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblVirtualRegion](
	[VirtualRegionID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblVirtu__346035B0FD3A30A0] PRIMARY KEY CLUSTERED 
(
	[VirtualRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditedHands]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditedHands](
	[AuditedHandID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[PersonelName] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[AreaID] [int] NULL,
	[ProcessID] [int] NULL,
	[Ekoli] [float] NULL,
	[Coliform] [float] NULL,
	[StaphAeurus] [float] NULL,
	[Statue] [bit] NULL,
	[Explanation1] [nvarchar](550) COLLATE Turkish_CI_AS NULL,
	[Explanation2] [nvarchar](550) COLLATE Turkish_CI_AS NULL,
	[AuditorID] [int] NULL,
	[NonAudit] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditedHandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CalAuditHandPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[V_CalAuditHandPoint]
as
select AuditPlanID,case Statue when 1 then count(Statue)
end as true,case Statue when 0 then count(Statue) end as false
 from TblAuditedHands WITH (NOLOCK)  where NonAudit=0 and Statue is not null group by AuditPlanID,Statue 



GO
/****** Object:  View [dbo].[V_CalTotalAuditHandsPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE View [dbo].[V_CalTotalAuditHandsPoint]
as
SELECT  [AuditPlanID],
sum(true) as true  ,sum(false) as false 
 FROM [SARDUNYADBNEW].[dbo].[V_CalAuditHandPoint] WITH (NOLOCK)
 group by AuditPlanID 
GO
/****** Object:  Table [dbo].[TblAuditedDevice]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditedDevice](
	[AuditedDeviceID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[DeviceID] [int] NULL,
	[AreaID] [int] NULL,
	[ProcessID] [int] NULL,
	[Result1] [float] NULL,
	[Result2] [float] NULL,
	[Result3] [float] NULL,
	[Statue] [bit] NULL,
	[Explanation1] [nvarchar](550) COLLATE Turkish_CI_AS NULL,
	[Explanation2] [nvarchar](550) COLLATE Turkish_CI_AS NULL,
	[AuditorID] [int] NULL,
	[NonAudit] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditedDeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CalAuditDevicePoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[V_CalAuditDevicePoint]
as
select AuditPlanID,case Statue when 1 then count(Statue)
end as true,case Statue when 0 then count(Statue) end as false
 from TblAuditedDevice WITH (NOLOCK)  where NonAudit=0 and Statue is not null group by AuditPlanID,Statue 




GO
/****** Object:  View [dbo].[V_CalTotalAuditDevicePoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE View [dbo].[V_CalTotalAuditDevicePoint]
as
SELECT  [AuditPlanID],
sum(true) as true  ,sum(false) as false 
 FROM [SARDUNYADBNEW].[dbo].[V_CalAuditDevicePoint] WITH (NOLOCK)
 group by AuditPlanID 
GO
/****** Object:  View [dbo].[V_CalculateHandDeviceRealizePointAffectPerformance]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[V_CalculateHandDeviceRealizePointAffectPerformance]
as
select p.LocationID,p.AuditPlanID,t.AffectPerformance,p.AuditDate,Year(p.AuditDate) as YearID,Month(p.AuditDate) as MonthID,r.TotalProcessPoint,
r.MajorPoint,r.QualityPoint,sum(h.true) as Htrue,sum(h.false) as Hfalse,
sum(d.true) as Dtrue,sum(d.false) as Dfalse
 from TblAuditRealize as r WITH (NOLOCK)
 inner join TblAuditPlan as p WITH (NOLOCK) on r.AuditPlanID=p.AuditPlanID
 inner join TblAuditType as t WITH (NOLOCK) on p.AuditTypeID=t.AuditTypeID
left outer join V_CalTotalAuditHandsPoint as h WITH (NOLOCK) on r.AuditPlanID=h.AuditPlanID and p.AuditPlanID=h.AuditPlanID
left outer join V_CalTotalAuditDevicePoint as d WITH (NOLOCK) on r.AuditPlanID=d.AuditPlanID and p.AuditPlanID=d.AuditPlanID
where p.LocationID is not null and t.AffectPerformance=1 and (YEAR(p.AuditDate)=YEAR(GETDATE()) OR YEAR(p.AuditDate)=YEAR(GETDATE())-1)
group by p.LocationID,p.AuditPlanID,p.AuditDate,r.TotalProcessPoint,r.MajorPoint,r.QualityPoint,t.AffectPerformance




GO
/****** Object:  View [dbo].[V_AvverageLocationAuditAffectPerformance]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[V_AvverageLocationAuditAffectPerformance]
as
select LocationID,MonthID,YearID,avg(TotalProcessPoint) as AvgCheckList,avg(QualityPoint) as QualityPoint,sum(MajorPoint) as MajorPoint
,sum(HTrue) clearHand,sum(HFalse) as dirtyHand,
sum(DTrue) clearDevice,sum(DFalse) as dirtyDevice
 from [dbo].[V_CalculateHandDeviceRealizePointAffectPerformance] WITH (NOLOCK)

 group by LocationID,MonthID ,YearID


GO
/****** Object:  View [dbo].[V_CalculateHandDeviceRealizePointNonAffectPerformance]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[V_CalculateHandDeviceRealizePointNonAffectPerformance]
as
select p.LocationID,p.AuditPlanID,t.AffectPerformance,p.AuditDate,Year(p.AuditDate) as YearID,Month(p.AuditDate) as MonthID,r.TotalProcessPoint,
r.MajorPoint,r.QualityPoint,sum(h.true) as Htrue,sum(h.false) as Hfalse,
sum(d.true) as Dtrue,sum(d.false) as Dfalse
 from TblAuditRealize as r WITH (NOLOCK)
 inner join TblAuditPlan as p WITH (NOLOCK) on r.AuditPlanID=p.AuditPlanID
 inner join TblAuditType as t WITH (NOLOCK) on p.AuditTypeID=t.AuditTypeID
left outer join V_CalTotalAuditHandsPoint as h WITH (NOLOCK) on r.AuditPlanID=h.AuditPlanID and p.AuditPlanID=h.AuditPlanID
left outer join V_CalTotalAuditDevicePoint as d WITH (NOLOCK) on r.AuditPlanID=d.AuditPlanID and p.AuditPlanID=d.AuditPlanID
where p.LocationID is not null and t.AffectPerformance=0
group by p.LocationID,p.AuditPlanID,p.AuditDate,r.TotalProcessPoint,r.MajorPoint,r.QualityPoint,t.AffectPerformance




GO
/****** Object:  View [dbo].[V_AvverageLocationAuditNonAffectPerformance]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[V_AvverageLocationAuditNonAffectPerformance]
as
select LocationID,YearID,MonthID,sum(MajorPoint) as MajorPoint
,sum(HTrue) clearHand,sum(HFalse) as dirtyHand,
sum(DTrue) clearDevice,sum(DFalse) as dirtyDevice
 from [dbo].[V_CalculateHandDeviceRealizePointNonAffectPerformance] WITH (NOLOCK)

 group by LocationID,MonthID ,YearID


GO
/****** Object:  View [dbo].[V_AvverageLocationAffectAndNonAffectPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_AvverageLocationAffectAndNonAffectPoint]
as
select
affect.LocationID as LocationID,affect.MonthID as MonthID,affect.YearID as YearID,
affect.AvgCheckList as CheckListPoint, (IsNull(affect.MajorPoint, 0)+IsNull(nonaffect.MajorPoint, 0)) as majorPoint,

affect.QualityPoint as QualityPoint,
(IsNull(affect.DirtyHand, 0)+IsNull(nonaffect.DirtyHand, 0)) as totalDirtyHand,
(IsNull(affect.ClearHand, 0)+IsNull(nonaffect.ClearHand, 0)) as totalClearHand,
(IsNull(affect.DirtyDevice, 0)+IsNull(nonaffect.DirtyDevice, 0)) as totalDirtyDevice,
(IsNull(affect.ClearDevice, 0)+IsNull(nonaffect.ClearDevice, 0)) as totalClearDevice
from V_AvverageLocationAuditAffectPerformance as affect  WITH (NOLOCK)
left outer join V_AvverageLocationAuditNonAffectPerformance as nonaffect WITH (NOLOCK)
 on affect.LocationID=nonaffect.LocationID
and  affect.MonthID=nonaffect.MonthID and affect.YearID=nonaffect.YearID

GO
/****** Object:  View [dbo].[V_AvveragePublishLocationPoints]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[V_AvveragePublishLocationPoints]
as

select LocationID,YearID,MonthID,
case when ((totalDirtyDevice+totalClearDevice)=0 and (totalDirtyHand+totalClearHand)=0  ) 
then ((CheckListPoint-majorPoint)*0.8+QualityPoint*0.2)
 when ((totalDirtyHand+totalClearHand)=0 and (totalDirtyDevice+totalClearDevice)>0  ) 
 then (((CheckListPoint)*0.9+(cast(totalClearDevice*10 as float)/(cast(totalClearDevice as float)+cast(totalDirtyDevice as float)))-majorPoint)*0.8++QualityPoint*0.2)
 when ((totalDirtyHand+totalClearHand)>0 and (totalDirtyDevice+totalClearDevice)=0  ) 
 then (((CheckListPoint)*0.9+(cast(totalClearHand*10 as float)/(cast(totalClearHand as float)+cast(totalDirtyHand as float)))-majorPoint)*0.8+QualityPoint*0.2)
 when ((totalDirtyHand+totalClearHand)>0 and (totalDirtyDevice+totalClearDevice)>0  ) 
 then (((CheckListPoint)*0.8+((cast(totalClearHand*10 as float)/(cast(totalClearHand as float)+cast(totalDirtyHand as float) ))+(cast(totalClearDevice*10 as float)/(cast(totalClearDevice as float)+cast(totalDirtyDevice as float))))-majorPoint)*0.8++QualityPoint*0.2)
 end as auditPoint, CheckListPoint,QualityPoint,
 cast (case 
 when (totalClearDevice+totalDirtyDevice>0) then 
 (cast(totalClearDevice as float)*10)/(cast(totalClearDevice as float)+cast(totalDirtyDevice as float))
 else null
  end as float)as devicePoint,
 cast( case 
  when (totalClearHand+totalDirtyHand)>0 then 
   (cast(totalClearHand as float)*10)/(cast(totalClearHand as float)+cast(totalDirtyHand as float)) else null end as float ) as handPoint,
   majorPoint,totalClearHand,totalDirtyHand,
 totalClearDevice,totalDirtyDevice
from V_AvverageLocationAffectAndNonAffectPoint WITH (NOLOCK)
GO
/****** Object:  Table [dbo].[TblEmployeeLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployeeLocation](
	[EmpLocationID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[AuthType] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Password] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PasswordToken] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblEmployeeLocation] PRIMARY KEY CLUSTERED 
(
	[EmpLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblRoles]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[PositionName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Explantion] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[RoleCode] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PowerBIPublishLocationPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[V_PowerBIPublishLocationPoint]
as
select distinct 
 v.LocationID,
 loc.LocationName,
 d.TypeDetailId,
 d.TypeName,
 rol.RoleID,
 rol.RoleName,
emp.EmployeeID,
emp.Name +' '+ emp.Surname as PersonelName,
v.YearID,
v.MonthID,
v.auditPoint,
v.CheckListPoint,
v.QualityPoint,
v.handPoint,
v.devicePoint,
v.majorPoint,
r.Name as "VirtualRegion"
from [dbo].[V_AvveragePublishLocationPoints] as v WITH (NOLOCK) inner join TblLocation as loc WITH (NOLOCK) on v.LocationID=loc.LocationID
left join  TblVirtualRegion as r WITH (NOLOCK) on r.VirtualRegionID=loc.RegionID
inner join TblTypeDetail as d WITH (NOLOCK) on loc.LocationTypeID=d.TypeDetailId
inner join TblEmployeeLocation as el WITH (NOLOCK) on v.LocationID=el.LocationID
inner join TblEmployee as emp WITH (NOLOCK) on el.EmployeeID=emp.EmployeeID
inner join TblRoles as rol WITH (NOLOCK) on emp.PositionRoleID=rol.RoleID
Where V.YearID= YEAR(GETDATE()-15)
GO
/****** Object:  Table [dbo].[TblUnitType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUnitType](
	[UnitID] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblUnitT__44F5EC95A961D4F3] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMaterialServices]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMaterialServices](
	[MaterialID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[UnitID] [int] NULL,
	[CatID] [int] NULL,
	[BrandName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblMater__C50613179090FDCC] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProductCategory]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProductCategory](
	[CatID] [int] IDENTITY(1,1) NOT NULL,
	[CatName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsService] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__TblProdu__6A1C8AFAF8AA378C] PRIMARY KEY CLUSTERED 
(
	[CatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Materials]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Materials] 
AS SELECT
  m.MaterialID
 ,m.MaterialName
 ,m.UnitID
 ,ut.UnitName
 ,m.CatID
 ,ct.CatName
 ,m.BrandName
 ,ct.IsService
FROM dbo.TblMaterialServices m WITH (NOLOCK)
LEFT OUTER JOIN dbo.TblUnitType ut WITH (NOLOCK)
  ON ut.UnitID = m.UnitID
LEFT OUTER JOIN dbo.TblProductCategory ct WITH (NOLOCK)
  ON ct.CatID = m.CatID

GO
/****** Object:  Table [dbo].[TblProvider]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProvider](
	[ProviderID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
	[ProviderTypeID] [int] NULL,
	[IsApproved] [bit] NULL,
	[WorkingFrequency] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[VirtualRegionID] [int] NULL,
	[Explanation] [nvarchar](450) COLLATE Turkish_CI_AS NULL,
	[PurchasedProduct] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[AuditTime] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[AuditCycleID] [int] NULL,
	[OperationID] [int] NULL,
	[AuditAcceptionID] [int] NULL,
	[ProductCategory] [varchar](150) COLLATE Turkish_CI_AS NULL,
	[TargetCycleID] [int] NULL,
 CONSTRAINT [PK__TblProvi__B54C689D8BBD1833] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderServices]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderServices](
	[ProviderServiceID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderID] [int] NULL,
	[MaterialID] [int] NULL,
	[CatId] [int] NULL,
	[IsApproved] [bit] NULL,
	[ServicePrice] [float] NULL,
	[ApprovedDate] [date] NULL,
	[ControlDate] [date] NULL,
	[IsSpecial] [bit] NULL,
	[ProviderPoint] [int] NULL,
 CONSTRAINT [PK__TblProvi__2205177E28CA5BB6] PRIMARY KEY CLUSTERED 
(
	[ProviderServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ProviderMaterials]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ProviderMaterials] 
AS select 
  ps.ProviderServiceID, 
  ps.ProviderID,
  p.Name ProviderName,
  ps.MaterialID,
  m.MaterialName,
  ps.CatId,
  m.CatName,
  ps.IsSpecial,
  ps.IsApproved,
  ps.ServicePrice,
  ps.ApprovedDate,
  ps.ControlDate

  from TblProviderServices ps WITH (NOLOCK)
  left outer join TblProvider p WITH (NOLOCK) on p.ProviderID=ps.ProviderID
  left outer join V_Materials m WITH (NOLOCK) on m.MaterialID=ps.MaterialID

GO
/****** Object:  Table [dbo].[TblProviderServicePlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderServicePlan](
	[PlanID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderServiceID] [int] NULL,
	[LocationID] [int] NULL,
	[EvidenceID] [int] NULL,
	[PlanDate] [date] NULL,
	[ServiceDate] [date] NULL,
	[RealDate] [date] NULL,
	[Status] [bit] NULL,
	[Result] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[ChargedPrice] [float] NULL,
	[Number] [int] NULL,
 CONSTRAINT [PK__TblProvi__755C22D7545363C6] PRIMARY KEY CLUSTERED 
(
	[PlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEvidence]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEvidence](
	[EvidenceID] [int] IDENTITY(1,1) NOT NULL,
	[EvidenceName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[DocumentID] [int] NULL,
	[AudReDetID] [int] NULL,
	[Explanation] [text] COLLATE Turkish_CI_AS NULL,
	[EvidenceLevelId] [int] NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_TblEvidence] PRIMARY KEY CLUSTERED 
(
	[EvidenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ProviderServicePlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ProviderServicePlan] 
AS select
sp.PlanID,
sp.ProviderServiceID,
pm.CatName,
pm.MaterialName,
sp.LocationID,
loc.LocationName,
sp.EvidenceID,
ev.Explanation EvidenceDesc,
sp.PlanDate,
sp.ServiceDate,
sp.RealDate,
sp.Status,
sp.Result,
sp.ChargedPrice,
sp.Number
from TblProviderServicePlan sp WITH (NOLOCK)
  left outer join TblLocation loc WITH (NOLOCK) on loc.LocationID=sp.LocationID
  left outer join V_ProviderMaterials pm WITH (NOLOCK) on pm.ProviderServiceID=sp.ProviderServiceID
  left outer join TblEvidence ev WITH (NOLOCK) on ev.EvidenceID=sp.EvidenceID

GO
/****** Object:  Table [dbo].[TblQuestion]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuestion](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[QDefination] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[QPoint] [float] NULL,
	[ToBeInform] [bit] NOT NULL,
	[QuestionTypeID] [int] NULL,
	[ScaleID] [int] NULL,
	[InformID] [int] NULL,
	[QSemiPoint] [float] NULL,
	[QLowPoint] [float] NULL,
	[Section] [nvarchar](10) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblQuestion] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblQuestionSetItems]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuestionSetItems](
	[QuestionSetItemsID] [int] IDENTITY(1,1) NOT NULL,
	[SetID] [int] NULL,
	[QuestionID] [int] NULL,
 CONSTRAINT [PK_TblQuestionSetItems] PRIMARY KEY CLUSTERED 
(
	[QuestionSetItemsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CalculateCheckList]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_CalculateCheckList]
as
select  distinct  d.AuditPlanID as AuditPlanID,q.QuestionTypeID as CatID,qs.SetID as SetID,q.QuestionID as QuestionID, q.QPoint as QPoint,d.ProcessPoint as ProcessPoint, d.TechnicalPoint as TecnicPoint,
d.InfrastructurePoint as InfastructurePoint,
d.BrokenType as BrokenType,d.IsNonAudit as Statue ,d.EvidenceIndex as EvidenceIndex,d.AuditorID as AuditorID, d.IsNonAudit as IsNonAudit
 from TblQuestion as q WITH (NOLOCK) inner join TblAuditRealizeDetail as d on q.QuestionID=d.QuestionID 
 inner join TblAuditPlan as ap WITH (NOLOCK) on d.AuditPlanID=ap.AuditPlanID
inner join TblQuestionSetItems as qs WITH (NOLOCK) on q.QuestionID=qs.QuestionID and d.QuestionID=qs.QuestionID and ap.QuesSetTypeID=qs.SetID 
where d.EvidenceIndex=0
GO
/****** Object:  View [dbo].[V_GetResponsibleLocationInfo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_GetResponsibleLocationInfo]
AS
SELECT distinct  lo.LocationID, 
rol.PositionName AS Pozisyonu, emp.Name + ' ' + emp.Surname AS PersonelAdi, 
typede.TypeName AS MutfakTipi, lo.LocationName AS MutfakAdi
FROM            
dbo.TblEmployee AS emp WITH (NOLOCK)
INNER JOIN dbo.TblEmployeeLocation AS emplo WITH (NOLOCK) ON emp.EmployeeID = emplo.EmployeeID 
LEFT OUTER JOIN dbo.TblLocation AS lo WITH (NOLOCK) ON emplo.LocationID = lo.LocationID 
LEFT OUTER JOIN  dbo.TblRoles AS rol WITH (NOLOCK) ON emp.PositionRoleID = rol.RoleID 
LEFT OUTER JOIN dbo.TblTypeDetail AS typede WITH (NOLOCK) ON lo.LocationTypeID = typede.TypeDetailId

GO
/****** Object:  Table [dbo].[TblAuditor]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditor](
	[AuditorID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ExpertID] [int] NOT NULL,
	[AttendDate] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[VirtualRegionID] [int] NULL,
	[Signuture] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblAudit__9821F4667363134C] PRIMARY KEY CLUSTERED 
(
	[AuditorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DilanDeneme]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[DilanDeneme] as
select r.AuditPlanID,p.AuditDate,
empp.Name+' '+empp.Surname as Denetci,
p.AuditTypeID,t.TypeName,t.AffectPerformance,p.LocationID,
l.LocationName,typd.TypeName as lokasyontürü,l.LocationTypeID,
l.RegionID ,v.Name,r.TotalPoint, r.TotalProcessPoint,
r.MajorPoint,r.HandSamplePoint,
r.ItemSamplePoint, r.ProcesTecnicPoint, r.ProcesInfraPoint,
r.InfraMajorPoint,r.TechMajorPoint,p.AuditOHS,
r.[QualityPoint] as KalitePuan,
poz.PersonelAdi,poz.Pozisyonu
from TblAuditRealize as r 
inner join  TblAuditPlan as p on r.AuditPlanID=p.AuditPlanID
left outer join TblAuditType as t on t.AuditTypeID = p.AuditTypeID 
left outer join TblLocation as l on l.LocationID= p.LocationID
left outer join TblVirtualRegion as v on l.RegionID=v.VirtualRegionID
left outer join TblTypeDetail as typd  on l.LocationTypeID = typd.TypeDetailId
left outer join TblAuditorAuditPlan as au on p.AuditPlanID =au.AuditPlanID
left outer join TblAuditor as a on au.AuditorID =a.AuditorID
left outer join TblEmployee as empp on a.EmployeeID =empp.EmployeeID
left outer join [dbo].[V_GetResponsibleLocationInfo] as poz on p.LocationID=poz.LocationID






GO
/****** Object:  View [dbo].[V_CalculateProviderCatID]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE view [dbo].[V_CalculateProviderCatID]
 as
 select distinct c.AuditPlanID as AuditPlanID, det.TypeDetailId as CatID from V_CalculateCheckList as c WITH (NOLOCK) inner join TblTypeDetail as det WITH (NOLOCK) on c.CatID=det.TypeDetailId
 
GO
/****** Object:  View [dbo].[V_AuditorEmployee]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_AuditorEmployee] 
AS SELECT        
  au.AuditorID, 
  au.EmployeeID, 
  au.ExpertID, 
  au.AttendDate, 
  au.IsActive, 
  e.Name, 
  e.Surname,
  au.VirtualRegionID,
  e.AccountID,
  e.CertificateID,
  e.ContactID,
  e.DepartmentID,
  e.ProfilImageUrl,
  au.Signuture
FROM dbo.TblAuditor AS au WITH (NOLOCK)
  INNER JOIN TblEmployee AS e WITH (NOLOCK) ON e.EmployeeID = au.EmployeeID

GO
/****** Object:  Table [dbo].[TblAuditLocations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditLocations](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[LocationTypeID] [int] NULL,
	[AuditTypeID] [int] NULL,
	[ExpertID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__TblAudit__2205177E9D7A217F] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblExpert]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblExpert](
	[ExpertID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblExper__7EDB3A38BF62841C] PRIMARY KEY CLUSTERED 
(
	[ExpertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_AuditorLocationType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_AuditorLocationType]
AS
SELECT        ae.AuditorID, ae.Name + ' ' + ae.Surname AS AuditorFullName, au.LocationTypeID
FROM            dbo.TblAuditLocations AS au WITH (NOLOCK) INNER JOIN
                         dbo.TblExpert AS ex WITH (NOLOCK) ON ex.ExpertID = au.ExpertID LEFT OUTER JOIN
                         dbo.V_AuditorEmployee AS ae WITH (NOLOCK) ON ae.ExpertID = ex.ExpertID



GO
/****** Object:  Table [dbo].[TblGroup]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblGroup](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[PeriodID] [int] NOT NULL,
 CONSTRAINT [PK_TblGroupLocationType] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblGroupLocationTypeAssignment]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblGroupLocationTypeAssignment](
	[GroupLocationTypeAssignmentID] [int] IDENTITY(1,1) NOT NULL,
	[TypeDetailID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
 CONSTRAINT [PK_TblGroupLocationTypeAssignment] PRIMARY KEY CLUSTERED 
(
	[GroupLocationTypeAssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPeriod]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPeriod](
	[PeriodID] [int] IDENTITY(1,1) NOT NULL,
	[PeriodName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Frequence] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Period] [int] NOT NULL,
	[FirstTime] [bit] NULL,
 CONSTRAINT [PK__TblPerio__E521BB36BEDB0119] PRIMARY KEY CLUSTERED 
(
	[PeriodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_LocationTypePeriod]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[V_LocationTypePeriod]
AS
SELECT        pe.PeriodID, pe.Period, pe.PeriodName, pe.Explanation, td.TypeDetailId,td.TypeName
FROM            dbo.TblTypeDetail AS td WITH (NOLOCK) INNER JOIN
                         dbo.TblGroupLocationTypeAssignment AS gl WITH (NOLOCK) ON td.TypeDetailId = gl.TypeDetailID LEFT OUTER JOIN
                         dbo.TblGroup AS g WITH (NOLOCK) ON g.GroupID = gl.GroupID LEFT OUTER JOIN
                         dbo.TblPeriod AS pe WITH (NOLOCK) ON pe.PeriodID = g.PeriodID




GO
/****** Object:  View [dbo].[V_AuditLocationAssignment]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_AuditLocationAssignment]
AS
SELECT     al.InckeyNo, al.IsActive,   ex.ExpertID, ex.Name AS ExpertName, lt.TypeDetailId AS LocationTypeId, lt.TypeName AS LocationTypeName, lt.PeriodID, lt.Explanation AS PeriodName, at.AuditTypeID, at.TypeName AS AuditTypeName
FROM            dbo.TblAuditLocations AS al WITH (NOLOCK) INNER JOIN
                         dbo.TblExpert AS ex WITH (NOLOCK) ON al.ExpertID = ex.ExpertID LEFT OUTER JOIN
                         dbo.V_LocationTypePeriod AS lt WITH (NOLOCK) ON lt.TypeDetailId = al.LocationTypeID LEFT OUTER JOIN
                         dbo.TblAuditType AS at WITH (NOLOCK) ON al.AuditTypeID = at.AuditTypeID





GO
/****** Object:  View [dbo].[V_AUDITOR]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_AUDITOR] AS
select pl.LocationID as locationID,avg(realize.TotalPoint) as AveragePoint from TblAuditRealize as realize WITH (NOLOCK) inner join TblAuditPlan as pl WITH (NOLOCK) on realize.AuditPlanID=pl.AuditPlanID
group by pl.LocationID


GO
/****** Object:  Table [dbo].[TblPermission]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPermission](
	[PermissionID] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NULL,
	[FinishDate] [date] NULL,
	[PermissionType] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[AuditorID] [int] NULL,
 CONSTRAINT [PK_TblPermission] PRIMARY KEY CLUSTERED 
(
	[PermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_AuditorPermission]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_AuditorPermission] 
AS SELECT
  p.PermissionID,
  p.StartDate,
  p.FinishDate,
  p.PermissionType,
  p.AuditorID,
  e.Name,
  e.Surname
  from TblPermission p WITH (NOLOCK)

  left outer join TblAuditor a WITH (NOLOCK) on a.AuditorID=p.AuditorID
  left outer join TblEmployee e WITH (NOLOCK) on e.EmployeeID = a.EmployeeID

GO
/****** Object:  Table [dbo].[TblRegulation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRegulation](
	[RegulationID] [int] IDENTITY(1,1) NOT NULL,
	[RegulationName] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[ProcedureDocumentID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblRegulation] PRIMARY KEY CLUSTERED 
(
	[RegulationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLevelDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLevelDetail](
	[LevelDetailID] [int] IDENTITY(1,1) NOT NULL,
	[LevelID] [int] NULL,
	[SubLevelName] [varchar](250) COLLATE Turkish_CI_AS NULL,
	[BreakPoint] [int] NULL,
 CONSTRAINT [PK_TblLevelDetail] PRIMARY KEY CLUSTERED 
(
	[LevelDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMajorGroup]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMajorGroup](
	[MajorGroupID] [int] IDENTITY(1,1) NOT NULL,
	[MajorGroupName] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[MajorGroupExplanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblMajorGroup] PRIMARY KEY CLUSTERED 
(
	[MajorGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_AuditRealizeMajor]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from [dbo].[V_AuditRealizeMajor]
CREATE VIEW [dbo].[V_AuditRealizeMajor]
AS
SELECT        r.AuditPlanID, p.AuditDate, empp.Name + ' ' + empp.Surname AS Denetci, p.AuditTypeID, t.TypeName, t.AffectPerformance, p.LocationID, l.LocationName, typd.TypeName AS lokasyontürü, l.LocationTypeID, l.RegionID, v.Name, 
                         r.TotalPoint, r.TotalProcessPoint, r.MajorPoint, r.HandSamplePoint, r.ItemSamplePoint, r.ProcesTecnicPoint, r.ProcesInfraPoint, r.InfraMajorPoint, r.TechMajorPoint, p.AuditOHS, r.QualityPoint AS KalitePuan, poz.PersonelAdi, 
                         poz.Pozisyonu,
						 rede.Explanation as AksiyonAciklama ,
						 rede.FirstResponsible as BirinciSorumlu,
						 rede.SecondResponsible as İkinciSorumlu,
						 rede.ThirdResponsible as UcuncuSorumlu,
						 levelDe.SubLevelName as MajorAdi,
						 regulation.[RegulationName] as Talimat,
						 mgroup.[MajorGroupName] as MajorGroup
FROM            dbo.TblAuditRealize AS r WITH (NOLOCK) INNER JOIN
                         dbo.TblAuditPlan AS p WITH (NOLOCK) ON r.AuditPlanID = p.AuditPlanID LEFT OUTER JOIN
                         dbo.TblAuditType AS t WITH (NOLOCK) ON t.AuditTypeID = p.AuditTypeID LEFT OUTER JOIN
                         dbo.TblLocation AS l WITH (NOLOCK) ON l.LocationID = p.LocationID LEFT OUTER JOIN
                         dbo.TblVirtualRegion AS v WITH (NOLOCK) ON l.RegionID = v.VirtualRegionID LEFT OUTER JOIN
                         dbo.TblTypeDetail AS typd WITH (NOLOCK) ON l.LocationTypeID = typd.TypeDetailId LEFT OUTER JOIN
                         dbo.TblAuditorAuditPlan AS au WITH (NOLOCK) ON p.AuditPlanID = au.AuditPlanID LEFT OUTER JOIN
                         dbo.TblAuditor AS a WITH (NOLOCK) ON au.AuditorID = a.AuditorID LEFT OUTER JOIN
                         dbo.TblEmployee AS empp WITH (NOLOCK) ON a.EmployeeID = empp.EmployeeID LEFT OUTER JOIN
                         dbo.V_GetResponsibleLocationInfo AS poz WITH (NOLOCK) ON p.LocationID = poz.LocationID
						 left outer join [dbo].[TblAuditRealizeDetail] as rede WITH (NOLOCK) on r.AuditPlanID=rede.AuditPlanID
						 left outer join [dbo].[TblLevelDetail] as levelDe WITH (NOLOCK) on rede.LevelID=levelDe.[LevelDetailID]
						 left outer join [dbo].[TblRegulation] as regulation WITH (NOLOCK) on rede.RegulationID=regulation.RegulationID
						 left outer join [dbo].[TblMajorGroup] as mgroup WITH (NOLOCK) on rede.[MajorGroupID]=mgroup.[MajorGroupID]
						 where rede.LevelID is not null

GO
/****** Object:  View [dbo].[V_AuditRegulation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_AuditRegulation]
AS
SELECT        au.AuditID, au.AuditName, au.RegulationID, au.AuditTypeID, au.Explanation, re.RegulationName, re.ProcedureDocumentID
FROM            dbo.TblAudit AS au WITH (NOLOCK) INNER JOIN
                         dbo.TblRegulation AS re WITH (NOLOCK) ON au.RegulationID = re.RegulationID





GO
/****** Object:  View [dbo].[V_AuditsLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_AuditsLocation] 
AS select
ap.AuditPlanID,
ap.PlanName,
ap.LocationID,
ap.AuditDate,
ap.IsAudited,
ap.IsApproved,
ap.PlannerID, 
ap.AuditTypeID,
at.TypeName AuditTypeName,

ap.QuesSetTypeID,
ap.AuditID,

a.AuditName,
ap.PeriodID,
ap.ProductCatID,
ap.IsActive,
ap.AuditorCount,
ap.AuditOHS,
aap.AuditorID,
aap.Statue,
aap.IsRealized,
aap.IsCompleted

from 
  TblAuditPlan ap WITH (NOLOCK)

left outer join TblAuditorAuditPlan aap WITH (NOLOCK) on aap.AuditPlanID=ap.AuditPlanID
left outer join TblAuditType at WITH (NOLOCK) on at.AuditTypeID=ap.AuditTypeID
left outer join TblAudit a WITH (NOLOCK) on a.AuditID=ap.AuditID

--where ap.IsAudited=0

GO
/****** Object:  View [dbo].[V_CalculateLocationCatID]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_CalculateLocationCatID]
as
select distinct a.AuditPlanID as PlanID,l.LocationID as locID,l.LocationTypeID as locCatID
 from TblAuditPlan as a WITH (NOLOCK) inner join TblLocation as l WITH (NOLOCK) on a.LocationID=l.LocationID 

GO
/****** Object:  View [dbo].[V_CalculateMajorPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[V_CalculateMajorPoint]
as
select 
ISNULL(ROW_NUMBER() OVER(ORDER BY d.AuditPlanID DESC), -1) AS RowID,d.AuditPlanID as PlanID,d.BrokenType as BrokenType,sum(det.BreakPoint) as MajorPoint from TblAuditRealizeDetail as d WITH (NOLOCK) inner join TblLevelDetail as det WITH (NOLOCK) on d.LevelID=det.LevelDetailID
 where d.LevelID is not null and d.BrokenType is not null group by  d.AuditPlanID,d.BrokenType
GO
/****** Object:  Table [dbo].[TblLocationTypeQuestionCatEffect]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationTypeQuestionCatEffect](
	[LocCatQuesID] [int] IDENTITY(1,1) NOT NULL,
	[LocTypeID] [int] NULL,
	[QuesCatID] [int] NULL,
	[Rate] [float] NULL,
	[IsQuality] [bit] NULL,
 CONSTRAINT [PK_TblLocationTypeQuestionCatEffect] PRIMARY KEY CLUSTERED 
(
	[LocCatQuesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CalculateQuestionCategoryPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[V_CalculateQuestionCategoryPoint] AS
select p.AuditPlanID,det.AuditorID, d.TypeName,
case when cat.IsQuality=1 then (sum(det.ProcessPoint)*100)/sum(q.QPoint) else sum(0) end as ProcessQualityCheckListPoint ,
case when cat.IsQuality=1 then (sum(det.TechnicalPoint)*100)/sum(q.QPoint) else sum(0) end as TecnicQualityCheckListPoint ,
case when cat.IsQuality=1 then (sum(det.InfrastructurePoint)*100)/sum(q.QPoint) else sum(0) end as InfrastructureQualityCheckListPoint ,
case when cat.IsQuality=0 then cat.Rate*((sum(det.ProcessPoint)*100)/sum(q.QPoint)) else sum(0) end as ProcessCheckListPoint ,
case when cat.IsQuality=0 then cat.Rate*((sum(det.TechnicalPoint)*100)/sum(q.QPoint)) else sum(0) end as TecnicCheckListPoint ,
case when cat.IsQuality=0 then cat.Rate*((sum(det.InfrastructurePoint)*100)/sum(q.QPoint)) else sum(0) end as InfrastructureCheckListPoint ,
case when cat.IsQuality=1 then 1 else 0 end as IsQuality 
from TblAuditRealizeDetail as det WITH (NOLOCK) 
inner join TblQuestion as q WITH (NOLOCK) on det.QuestionID=q.QuestionID 
inner join TblTypeDetail as d WITH (NOLOCK) on q.QuestionTypeID=TypeDetailId inner join TblAuditPlan as p WITH (NOLOCK) on det.AuditPlanID=p.AuditPlanID 
inner join TblLocation as l WITH (NOLOCK) on p.LocationID=l.LocationID 
inner join TblLocationTypeQuestionCatEffect as cat WITH (NOLOCK) on l.LocationTypeID=cat.LocTypeID  and q.QuestionTypeID=cat.QuesCatID where det.IsNonAudit=0  group by TypeName,cat.Rate,cat.IsQuality,p.AuditPlanID,det.AuditorID





GO
/****** Object:  Table [dbo].[TblDevices]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDevices](
	[DeviceID] [int] IDENTITY(1,1) NOT NULL,
	[DeviceName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblDevices] PRIMARY KEY CLUSTERED 
(
	[DeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_AuditRealizeHandAndDevice]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[V_AuditRealizeHandAndDevice]
AS
SELECT       
r.AuditPlanID, p.AuditDate,
empp.Name + ' ' + empp.Surname AS Denetci, 
p.AuditTypeID, t.TypeName, t.AffectPerformance, 
p.LocationID, l.LocationName, typd.TypeName AS lokasyontürü, 
l.LocationTypeID, l.RegionID, v.Name, 
r.TotalPoint, r.TotalProcessPoint, r.MajorPoint,
r.HandSamplePoint, r.ItemSamplePoint, r.ProcesTecnicPoint, 
r.ProcesInfraPoint, r.InfraMajorPoint, r.TechMajorPoint, 
p.AuditOHS, r.QualityPoint AS KalitePuan, poz.PersonelAdi, 
poz.Pozisyonu,
hand.[AuditedHandID],
hand.[PersonelName],
hand.[Ekoli],
hand.[Coliform],
hand.[StaphAeurus],
hand.[Statue] as ElDurumu,
hand.[Explanation1],
hand.[Explanation2],
device.[AuditedDeviceID],
dev.[DeviceName],
device.[Result1],
device.[Statue] as AracDurumu


FROM            
dbo.TblAuditRealize AS r WITH (NOLOCK) INNER JOIN dbo.TblAuditPlan AS p WITH (NOLOCK) ON r.AuditPlanID = p.AuditPlanID
LEFT OUTER JOIN dbo.TblAuditType AS t WITH (NOLOCK) ON t.AuditTypeID = p.AuditTypeID 
LEFT OUTER JOIN dbo.TblLocation AS l WITH (NOLOCK) ON l.LocationID = p.LocationID 
LEFT OUTER JOIN dbo.TblVirtualRegion AS v WITH (NOLOCK) ON l.RegionID = v.VirtualRegionID 
LEFT OUTER JOIN dbo.TblTypeDetail AS typd WITH (NOLOCK) ON l.LocationTypeID = typd.TypeDetailId 
LEFT OUTER JOIN dbo.TblAuditorAuditPlan AS au WITH (NOLOCK) ON p.AuditPlanID = au.AuditPlanID
LEFT OUTER JOIN dbo.TblAuditor AS a WITH (NOLOCK) ON au.AuditorID = a.AuditorID
LEFT OUTER JOIN dbo.TblEmployee AS empp WITH (NOLOCK) ON a.EmployeeID = empp.EmployeeID 
LEFT OUTER JOIN dbo.V_GetResponsibleLocationInfo AS poz WITH (NOLOCK) ON p.LocationID = poz.LocationID 
LEFT OUTER JOIN [dbo].[TblAuditedHands] as hand WITH (NOLOCK) on r.AuditPlanID=hand.AuditPlanID
LEFT OUTER JOIN [dbo].[TblAuditedDevice] as device WITH (NOLOCK) on r.AuditPlanID=device.AuditPlanID
LEFT OUTER JOIN [dbo].[TblDevices] as dev WITH (NOLOCK) on device.[DeviceID]=dev.[DeviceID]



GO
/****** Object:  Table [dbo].[TblCity]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCity](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NULL,
	[City] [nvarchar](150) COLLATE Turkish_CI_AS NOT NULL,
 CONSTRAINT [PK_TblCity] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_CityLocationType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from V_CityLocationType where V_CityLocationType.CityID=34
CREATE VIEW [dbo].[V_CityLocationType]
AS
SELECT DISTINCT td.TypeDetailId, td.TypeName, ci.CityID, l.LocationID
FROM            dbo.TblLocation AS l WITH (NOLOCK) INNER JOIN
                         dbo.TblContact AS c WITH (NOLOCK) ON c.ContactID = l.ContactID
						 left outer join dbo.TblCity AS ci WITH (NOLOCK) ON ci.CityID = c.CityID 
						 left outer join dbo.TblTypeDetail AS td WITH (NOLOCK) ON td.TypeDetailId = l.LocationTypeID






GO
/****** Object:  Table [dbo].[TblPleasure]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasure](
	[PleasureID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentNO] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[PublishDate] [date] NULL,
	[RevizNo] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[LcoationID] [int] NULL,
	[ProjectMannager] [int] NULL,
	[ProjectMannagerMission] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[CustomerMannagementName] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[CusManPhone] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[CusManIsInfo] [bit] NULL,
	[PleasuredPersonelName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[PleaPerMission] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[PleaPerPhone] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PleasureType] [bit] NULL,
	[PleasureSource] [bit] NULL,
	[PleasuredLevelInstant] [bit] NULL,
	[PleasuredLevelImmediate] [bit] NULL,
	[PleasuredLevelRoutine] [bit] NULL,
	[PleasuredLevelCritical] [bit] NULL,
	[PleasureExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[FirtFeedBack] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[FeedBackType] [bit] NULL,
	[FeedBackPersonelName] [int] NULL,
	[CustomerReaction] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CloseDate] [date] NULL,
	[ReturnType] [bit] NULL,
	[ReturnedPersonel] [int] NULL,
	[CustomerPleasure] [bit] NULL,
	[IsActive] [bit] NULL,
	[PleasureDate] [date] NULL,
	[ReturnCusDate] [date] NULL,
	[ProjectManPhone] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[DeliverID] [int] NULL,
	[PleasureExpID] [int] NULL,
	[substanceID] [int] NULL,
	[CustomerReturnClaim] [int] NULL,
	[SpokenReturnExp] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[FirstReturnCorrection] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[SekondReturnPerID] [int] NULL,
	[SecondReturnDate] [date] NULL,
	[ThirdReturnPerID] [int] NULL,
	[ThirdReturnDate] [date] NULL,
	[CompanyType] [int] NULL,
	[KitchenSourceType] [int] NULL,
	[PleasureCreateDate] [date] NULL,
	[SecondTurnType] [bit] NULL,
	[SecondTurnInfo] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ThirdTurnType] [bit] NULL,
	[ThirdTurnInfo] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[PleasureStatue] [int] NULL,
	[PleasureNo] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[RootCauseID] [int] NULL,
	[Cancel] [bit] NULL,
	[CloseUpdate] [bit] NULL,
 CONSTRAINT [PK__TblPleas__F56962ECC2BA84CA] PRIMARY KEY CLUSTERED 
(
	[PleasureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Complain]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Complain] 
AS SELECT
p.PleasureID,
p.LcoationID,
loc.LocationName,
p.PleasureDate,
p.PleasureSource,
p.PleasureType,
p.IsActive,
p.CloseDate,
p.PleaPerMission,
p.PleaPerPhone,
p.PleasureExplanation,
p.FirtFeedBack,
p.CustomerReaction,
p.PleasuredPersonelName,
p.PleasuredLevelImmediate,
p.PleasuredLevelRoutine,
p.PleasuredLevelInstant

from TblPleasure p WITH (NOLOCK)
left outer join TblLocation loc WITH (NOLOCK) on loc.LocationID=p.LcoationID

GO
/****** Object:  Table [dbo].[TblDocument]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDocument](
	[DocumentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[DocumentTypeID] [int] NULL,
	[DocGroupID] [int] NULL,
	[Path] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[AuditedHandId] [int] NULL,
	[AuditedDeviceId] [int] NULL,
	[OpeningCorrectiveActivityId] [int] NULL,
 CONSTRAINT [PK_TblDocument] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDocumentGroup]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDocumentGroup](
	[DocGroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[DocumentTypeID] [int] NULL,
 CONSTRAINT [PK_TblDocumentGroup] PRIMARY KEY CLUSTERED 
(
	[DocGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Document]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Document] 
AS select 
d.DocumentID,
d.Name,
d.DocumentTypeID,
dt.TypeName DocumentTypeName,
d.DocGroupID,
dg.GroupName DocGroupName,
d.Path,
d.Explanation
  from TblDocument d WITH (NOLOCK)
  left outer join TblTypeDetail dt WITH (NOLOCK) on dt.TypeDetailId=d.DocumentTypeID 
  left outer join TblDocumentGroup dg WITH (NOLOCK) on dg.DocGroupID = d.DocGroupID

GO
/****** Object:  View [dbo].[V_EmpLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_EmpLocation] 
AS SELECT
  el.EmpLocationID,
  el.EmployeeID,
  e.Name FirstName,
  e.Surname,
  el.LocationID,
  l.LocationName


  from TblEmployeeLocation el WITH (NOLOCK)

  left outer join TblEmployee e WITH (NOLOCK) on e.EmployeeID=el.EmployeeID
  left outer JOIN TblLocation l WITH (NOLOCK) on l.LocationID = el.LocationID

GO
/****** Object:  View [dbo].[V_Employee]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Employee] 
AS select  
  emp.EmployeeID,
  emp.Name, 
  emp.Surname,
  emp.ProfilImageUrl,
  emp.AccountID,
  emp.IsActive,
  emp.CertificateID,
  emp.DepartmentID,
  dep.DepartmentName,
  emp.ContactID,
  con.ContactName,
  con.Phone,
  con.Mobile,
  con.Email,
  ct.City
  from TblEmployee emp WITH (NOLOCK)

  left outer join TblDepartment dep WITH (NOLOCK) on dep.DepartmentID = emp.DepartmentID
  left outer join TblContact con WITH (NOLOCK) on con.ContactID = emp.ContactID
  left outer join TblCity ct WITH (NOLOCK) on ct.CityID = con.CityID

GO
/****** Object:  View [dbo].[V_CalculateHandDeviceRealizePoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[V_CalculateHandDeviceRealizePoint]
as
select p.LocationID,p.AuditPlanID,t.AffectPerformance,p.AuditDate,r.TotalProcessPoint,
r.MajorPoint,r.QualityPoint,sum(h.true) as Htrue,sum(h.false) as Hfalse,
sum(d.true) as Dtrue,sum(d.false) as Dfalse
 from TblAuditRealize as r WITH (NOLOCK)
 inner join TblAuditPlan as p WITH (NOLOCK) on r.AuditPlanID=p.AuditPlanID
 inner join TblAuditType as t WITH (NOLOCK) on p.AuditTypeID=t.AuditTypeID
left outer join V_CalTotalAuditHandsPoint as h WITH (NOLOCK) on r.AuditPlanID=h.AuditPlanID and p.AuditPlanID=h.AuditPlanID
left outer join V_CalTotalAuditDevicePoint as d WITH (NOLOCK) on r.AuditPlanID=d.AuditPlanID and p.AuditPlanID=d.AuditPlanID
where p.LocationID is not null 
group by p.LocationID,p.AuditPlanID,p.AuditDate,r.TotalProcessPoint,r.MajorPoint,r.QualityPoint,t.AffectPerformance


GO
/****** Object:  Table [dbo].[TblCertificate]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCertificate](
	[CertificateID] [int] IDENTITY(1,1) NOT NULL,
	[CertificateName] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CertificatedBy] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[IsObligatory] [bit] NULL,
	[PeriodID] [int] NULL,
	[CertificateTypeID] [int] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CertificateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblExpertDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblExpertDetail](
	[ExpertDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ExpertID] [int] NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[CertificateID] [int] NULL,
 CONSTRAINT [PK__TblExper__53E2E7288FE9FA66] PRIMARY KEY CLUSTERED 
(
	[ExpertDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ExpertDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ExpertDetail] 
AS SELECT
  ed.ExpertDetailID,
  ed.ExpertID,
  e.Name ExpertName,
  ed.Name ExpertDetailNanme,
  ed.CertificateID,
  c.CertificateName,
  c.IsObligatory
from TblExpertDetail ed WITH (NOLOCK)
  left outer join TblExpert e WITH (NOLOCK) on e.ExpertID=ed.ExpertID
  left outer join TblCertificate c WITH (NOLOCK) on c.CertificateID=ed.CertificateID

GO
/****** Object:  Table [dbo].[TblRegion]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRegion](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nchar](50) COLLATE Turkish_CI_AS NULL,
	[RegionName] [nchar](150) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblRegion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Location]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Location] 
AS select 
  loc.LocationID,
  loc.LocationName,
  loc.LocationTypeID,
  lt.TypeName LocationTypeName,
  loc.ContactID,
  c.ContactName,
  cc.City,
  c.Phone,
  c.Mobile,
  c.Fax,
  loc.RegionID,
  tr.Name VirtualRegionName,
  cr.RegionName,
  
  loc.IsActive,
  loc.SignatureCode
  FROM TblLocation loc WITH (NOLOCK)
  left OUTER JOIN TblTypeDetail lt WITH (NOLOCK) on lt.TypeDetailID=loc.LocationTypeID
  left outer JOIN TblContact c WITH (NOLOCK) on c.ContactID=loc.ContactID
  left outer JOIN TblCity cc WITH (NOLOCK) on cc.CityID=c.CityID
  left outer JOIN TblVirtualRegion tr WITH (NOLOCK) on tr.VirtualRegionID=loc.RegionID
  left outer JOIN TblRegion cr WITH (NOLOCK) on cr.RegionID=cc.RegionID

GO
/****** Object:  View [dbo].[V_LocationAverageAuditPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_LocationAverageAuditPoint]
AS
SELECT        p.LocationID, AVG(r.TotalPoint) AS Expr1
FROM            dbo.TblAuditPlan AS p WITH (NOLOCK) INNER JOIN
                         dbo.TblAuditRealize AS r WITH (NOLOCK) ON p.AuditPlanID = r.AuditPlanID
GROUP BY p.LocationID

GO
/****** Object:  View [dbo].[V_LocationAveragePoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[V_LocationAveragePoint]
as
select loc.LocationID as locationID,avg(realize.TotalPoint) as AveragePoint from TblAuditRealize as realize WITH (NOLOCK) inner join TblAuditPlan as pl WITH (NOLOCK) on realize.AuditPlanID=pl.AuditPlanID inner join TblLocation as loc WITH (NOLOCK) on pl.LocationID=loc.LocationID
group by loc.LocationID
--select * from V_LocationAveragePoint

GO
/****** Object:  View [dbo].[V_LocationGroup]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_LocationGroup] 
AS
select 
  g.GroupID,
  g.GroupName,
  g.Explanation,
  g.PeriodID,
  p.PeriodName,
  p.Explanation PeriodDesc
  from TblGroup g WITH (NOLOCK)

  left outer join TblPeriod p WITH (NOLOCK) on p.PeriodID=g.PeriodID

GO
/****** Object:  Table [dbo].[TblTowns]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTowns](
	[TownId] [int] IDENTITY(1,1) NOT NULL,
	[CityID] [int] NOT NULL,
	[Town] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblTowns] PRIMARY KEY CLUSTERED 
(
	[TownId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Provider]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Provider] 
AS select 
  p.ProviderID,
  p.Name,
  p.IsActive,
  p.ProviderTypeID,
  pt.TypeName ProviderTypeName,
  p.IsApproved,
  p.WorkingFrequency,
  p.VirtualRegionID,
  vr.Name VirtualRegionName,
  c.ContactName,
  c.Address,
  c.Mobile,
  c.Phone,
  c.Fax,
  c.Country,
  c.CityID,
  city.City,
  c.TownID,
  town.Town

  from TblProvider p WITH (NOLOCK)
 left outer join TblTypeDetail pt WITH (NOLOCK) on pt.TypeDetailId=p.ProviderTypeID
 left outer join TblContact c WITH (NOLOCK) on c.ProviderID=p.ProviderID
 left outer join TblCity city WITH (NOLOCK) on city.CityID = c.CityID
 left outer join TblVirtualRegion vr WITH (NOLOCK) on vr.VirtualRegionID = p.VirtualRegionID
 left outer join TblTowns town WITH (NOLOCK) on town.TownId= c.TownID

GO
/****** Object:  View [dbo].[V_PROVIDER_DETAIL]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_PROVIDER_DETAIL] as
select pro.Name as TEDARIKCI ,pro.WorkingFrequency as SINIF ,ty.TypeName as TIP, mat.MaterialName as URUNADI, mat.BrandName as MARKA, serp.PlanDate as PLANLANAN, serp.RealDate as GERÇEKLESEN
from TblProvider as pro WITH (NOLOCK) left join TblTypeDetail as ty WITH (NOLOCK) on ty.TypeDetailId=pro.ProviderTypeID
                        left join TblProviderServices as ser WITH (NOLOCK) on ser.ProviderID=pro.ProviderID 
                        left join TblMaterialServices as mat WITH (NOLOCK) on mat.MaterialID=ser.MaterialID
						left join TblProviderServicePlan as serp WITH (NOLOCK) on serp.ProviderServiceID=ser.ProviderServiceID
GO
/****** Object:  Table [dbo].[TblQuestionSet]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuestionSet](
	[SetID] [int] IDENTITY(1,1) NOT NULL,
	[SetName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SetInfoID] [int] NULL,
 CONSTRAINT [PK_TblQuestionSet] PRIMARY KEY CLUSTERED 
(
	[SetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PowerBI_UnsuitabilityTrying]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_PowerBI_UnsuitabilityTrying] AS
SELECT
ap.AuditPlanID,
ard.questionID,
ap.AuditDate,
case 
	when ap.AuditOHS = 0 then 'ISGDEGIL'
	when ap.AuditOHS = 1 then 'ISG'
	else 'HATAISG' 
	end as 'ISGMI?',
s.SetName as SetName,
q.Section,
q.QDefination,
ard.explanation, 
CASE
    WHEN ard.ProcessPoint= ard.TechnicalPoint THEN 'Altyapı'
    WHEN ard.ProcessPoint= ard.InfrastructurePoint THEN 'Teknik'
    WHEN ard.TechnicalPoint= ard.InfrastructurePoint THEN 'Uygulama'
    ELSE '----'
END AS 'Status',
ld.SubLevelName,
case 
	when ard.IsRegulatoryActivity = 0 then 'MINOR'
	when ard.IsRegulatoryActivity = 1 then 'MAJOR'
	else 'HATAMAJOR' 
	end as 'SEVIYE?',

case 
	when ard.IsNonAudit = 0 then 'DENETIMICI'
	when ard.IsNonAudit = 1 then 'DENETIMDISI'
	else 'HATADD' 
	end as 'DENETIMDISI?',
at.TypeName,

vr.Name,
td1.TypeName Soru,
e.Name + ' ' + e.Surname as DENETCI

,ap.LocationID
,ap.DepartmentID
,l.LocationName
,d.DepartmentName

FROM [SARDUNYADBNEW].[dbo].TblAuditPlan as ap WITH (NOLOCK)

inner join [SARDUNYADBNEW].[dbo].TblAuditRealizeDetail as ard WITH (NOLOCK) on ard.AuditPlanID=ap.AuditPlanID
full join [SARDUNYADBNEW].[dbo].TblLevelDetail as ld WITH (NOLOCK) on ld.LevelDetailID=ard.LevelID 
inner join [SARDUNYADBNEW].[dbo].TblAuditType as at WITH (NOLOCK) on at.AuditTypeID=ap.AuditTypeID 
inner join [SARDUNYADBNEW].[dbo].TblQuestion as q WITH (NOLOCK) on q.QuestionID=ard.QuestionID
inner Join [SARDUNYADBNEW].[dbo].TblTypeDetail as td1 WITH (NOLOCK) on td1.TypeDetailId=q.QuestionTypeID
inner join [SARDUNYADBNEW].[dbo].TblAuditorAuditPlan as aap WITH (NOLOCK) on aap.AuditPlanID=ap.AuditPlanID
inner join [SARDUNYADBNEW].[dbo].TblAuditor as a WITH (NOLOCK) on a.AuditorID=aap.AuditorID
inner join [SARDUNYADBNEW].[dbo].TblEmployee as e WITH (NOLOCK) on e.EmployeeID=a.EmployeeID
inner join [SARDUNYADBNEW].[dbo].TblQuestionSet as s  WITH(NOLOCK) on ap.QuesSetTypeID=s.SetID
full join [SARDUNYADBNEW].[dbo].TblLocation as l WITH (NOLOCK) on l.LocationID=ap.LocationID
full join [SARDUNYADBNEW].[dbo].TblVirtualRegion as vr WITH (NOLOCK) on vr.VirtualRegionID=l.RegionID
full join [SARDUNYADBNEW].[dbo].TblDepartment as d WITH (NOLOCK) on d.DepartmentID=ap.DepartmentID
inner join [SARDUNYADBNEW].[dbo].TblAudit as [audit] WITH (NOLOCK) on ap.AuditID = [audit].AuditID
where
ard.Explanation is not null 
GO
/****** Object:  Table [dbo].[TblPeriodicProviderService]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPeriodicProviderService](
	[PerServiceID] [int] IDENTITY(1,1) NOT NULL,
	[LocationIdD] [int] NULL,
	[Location2ID] [int] NULL,
	[ProviderID] [int] NULL,
	[TotalPrice] [float] NULL,
	[ServiceDate] [date] NULL,
	[RealDate] [date] NULL,
	[PlanDate] [date] NULL,
	[LabSampleID] [int] NULL,
	[PeriodID] [int] NULL,
	[DocumentID] [int] NULL,
	[Result] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ActionType] [int] NULL,
	[ProviderNote] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Status] [bit] NULL,
	[InvoiceType] [int] NULL,
	[OtherInvoice] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[Approve] [bit] NULL,
	[IsProviderInfo] [bit] NULL,
	[StatusInfo] [int] NULL,
	[DemandID] [int] NULL,
	[IsImportant] [bit] NULL,
	[ContactPerson] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[ProjectAddress] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ContactTelephone] [nvarchar](15) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblPerio__D133441FB7D70157] PRIMARY KEY CLUSTERED 
(
	[PerServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabSample]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabSample](
	[SampleID] [int] IDENTITY(1,1) NOT NULL,
	[SampleName] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[SampleType] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_ProviderPeriodicServices]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ProviderPeriodicServices] 
AS select
ps.PerServiceID,
ps.LocationIdD,
loc.LocationName,
ps.ProviderID,
ps.TotalPrice,
ps.ServiceDate,
ps.RealDate,
ps.PlanDate,
ps.LabSampleID,
ls.SampleName,
ps.PeriodID,
pr.PeriodName,
ps.DocumentID
from TblPeriodicProviderService ps WITH (NOLOCK)

  left outer join TblLocation loc WITH (NOLOCK) on loc.LocationID=ps.LocationIdD
  left outer join TblLabSample ls WITH (NOLOCK) on ls.SampleID=ps.LabSampleID
  left outer join TblPeriod pr WITH (NOLOCK) on pr.PeriodID=ps.PeriodID

GO
/****** Object:  View [dbo].[V_QuesSetItems]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_QuesSetItems] 
AS SELECT
  items.QuestionSetItemsID,
  items.SetID,
  qset.SetName,
  items.QuestionID,
  qs.QName,
  qs.QDefination,
  qs.QuestionTypeID,
  td.TypeName QTypeName
from TblQuestionSetItems items WITH (NOLOCK)
  left outer join TblQuestionSet qset WITH (NOLOCK) on qset.SetID=items.SetID
  left outer join TblQuestion qs WITH (NOLOCK) on qs.QuestionID=items.QuestionID
  left outer join TblTypeDetail td WITH (NOLOCK) on td.TypeDetailId=qs.QuestionTypeID

GO
/****** Object:  View [dbo].[V_Question]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_Question] 
AS select 
  qs.QuestionID,
  qs.QName,
  qs.QDefination,
  qs.QPoint,
  qs.ToBeInform,
  qs.QuestionTypeID,
  qt.TypeName QuestionTypeName,
  qs.ScaleID,
  qs.InformID,
  qs.QSemiPoint,
  qs.QLowPoint
  from TblQuestion qs WITH (NOLOCK)
  left outer join TblTypeDetail qt WITH (NOLOCK) on qt.TypeDetailID=qs.QuestionTypeID

GO
/****** Object:  View [dbo].[V_QuestionSet]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_QuestionSet] 
AS select
  qset.SetID,
  qset.SetName,
  qset.Explanation,
  (select count(*) from TblQuestionSetItems WITH (NOLOCK) where SetID=qset.SetID) QuestionCount
from TblQuestionSet qset WITH (NOLOCK)

GO
/****** Object:  Table [dbo].[TblPleasureRootCause]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureRootCause](
	[RootCauseID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblPleasureRootCause] PRIMARY KEY CLUSTERED 
(
	[RootCauseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureForeignSubstance]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureForeignSubstance](
	[Substance] [int] IDENTITY(1,1) NOT NULL,
	[SubstanceName] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblPleasureForeign Substance] PRIMARY KEY CLUSTERED 
(
	[Substance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureDeliverType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureDeliverType](
	[DeliverID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveName] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblPleasureDeliverType] PRIMARY KEY CLUSTERED 
(
	[DeliverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureExplanationHelp]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureExplanationHelp](
	[PleasureExpID] [int] IDENTITY(1,1) NOT NULL,
	[PleasureExp] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblPleasureExplanationHelp] PRIMARY KEY CLUSTERED 
(
	[PleasureExpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PowerbiPleasure]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--USE [NetAuditDB]
--GO

--/****** Object:  View [dbo].[PowerbiPleasure]    Script Date: 18.07.2018 13:46:51 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

----USE [NetAuditDB]
----GO

----/****** Object:  View [dbo].[PowerbiPleasure]    Script Date: 17.07.2018 21:18:34 ******/
----SET ANSI_NULLS ON
----GO

----SET QUOTED_IDENTIFIER ON
----GO





----/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[PowerbiPleasure] as 
SELECT 
	pl.[PleasureID],
    pl.[PleasureNo],
    pl.[LcoationID],
	l.LocationName,
	poz.PersonelAdi, 
    poz.Pozisyonu,
    pl.[PleasuredPersonelName] as "Müşteri Adı",
    pl.[PleasureDate] as "Şikayet Tarihi",
	pl.[DeliverID],
	dt.[DeliveName],
	pl.[PleasureExplanation],
	d.TypeName as "LocationType",
	CASE  /*Şikayetin Sebebi*/
		WHEN [PleasuredLevelInstant]=1 then 'ANLIK'
		WHEN [PleasuredLevelImmediate]=1 then 'ACİL'
		WHEN [PleasuredLevelRoutine] =1 then 'RUTİN'
		WHEN [PleasuredLevelCritical] =1 then 'KRİTİK'
		ELSE 'BOŞ'
	END AS "Seviye",
	CASE/*Tedarikçi Kaynaklı mı Mutfak Kaynaklı mı?*/
		WHEN [PleasureSource] = 1 then 'TEDARİKÇİ'
		WHEN [KitchenSourceType] =1 THEN 'MERKEZ MUTFAK'
		WHEN [KitchenSourceType] =2 THEN 'TAŞIMA MUTFAK'
		WHEN [KitchenSourceType] =3 THEN 'YERİNDE MUTFAK' 
		ELSE 'BOŞ'
	END AS "Sebep Yeri",
    ex.[PleasureExp],
	fs.[SubstanceName],
	rc.[Name],
	CASE 
		WHEN pl.[SecondReturnDate] IS NULL AND pl.[ThirdReturnDate] is null and [ReturnCusDate] is null AND [FirtFeedBack] is null THEN 'DÖNÜLMEDİ'
		ELSE 'DÖNÜLDÜ'
	END AS "DURUM",

	CASE
		WHEN pl.[FeedBackType] = 1 then 'YAZILI'
		WHEN pl.[FeedBackType] =0 THEN 'SÖZLÜ'
	END AS "DÖNÜŞ YOLU",
	pl.[ReturnCusDate] as "İlk Dönüş Tarihi",
	pl.[FirstReturnCorrection] as "İlk Dönüş",
	pl.[SecondReturnDate] as "İkinci Dönüş Tarihi",
	pl.[SecondTurnInfo] as "İkinci Dönüş",
	pl.[ThirdReturnDate] as "Üçüncü Dönüş Tarihi",
	pl.[ThirdTurnInfo] as "Üçüncü Dönüş",
	CASE
		WHEN pl.[IsActive]=1 THEN 'AÇIK'
		ELSE 'KAPALI'
	END AS "CLOSE",
	pl.CloseDate ,
	v.Name as "VirtualRegion"

  FROM [NetAuditDB].[dbo].[TblPleasure] pl WITH (NOLOCK) left join dbo.V_GetResponsibleLocationInfo poz
       ON pl.LcoationID = poz.LocationID 
	   LEFT JOIN dbo.TblLocation AS l WITH (NOLOCK) ON pl.LcoationID =l.LocationID 
	   LEFT JOIN TblTypeDetail as d WITH (NOLOCK) on d.TypeDetailId=l.LocationTypeID
	   LEFT JOIN TblVirtualRegion as v WITH (NOLOCK)  ON v.VirtualRegionID=l.RegionID
	   LEFT JOIN [dbo].[TblPleasureExplanationHelp] ex WITH (NOLOCK) ON pl.[PleasureExpID] =ex.[PleasureExpID]
	   LEFT JOIN [dbo].[TblPleasureForeignSubstance] fs WITH (NOLOCK) ON pl.[substanceID] = fs.[Substance]
	   LEFT JOIN [dbo].[TblPleasureRootCause] rc WITH (NOLOCK) ON pl.[RootCauseID] = rc.[RootCauseID]
	   LEFT JOIN [dbo].[TblPleasureDeliverType] dt WITH (NOLOCK) ON pl.DeliverID =dt.[DeliverID]
  
  --WHERE   /* İKÜ, BMY, BM, OD, ODY verisini getirir.*/
--	poz.Pozisyonu in (select roles.RoleName from [dbo].[TblRoles] as roles where roles.RoleID in (5,6,18,3,4)) 
 -- AND  PleasureID =26
 Where poz.Pozisyonu in ('Operasyon Direktörü','Operasyon Direktörü Yardımcısı','Bölge Müdürü','Bölge Müdür Yardımcısı','İKÜ')


 --select * from [NetAuditDB].[dbo].[TblPleasure] pl left join dbo.V_GetResponsibleLocationInfo poz
 --      ON pl.LcoationID = poz.LocationID 






GO
/****** Object:  View [dbo].[V_Regulation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Regulation] 
AS SELECT
  r.RegulationID,
  r.RegulationName,
  r.DocumentID,
  r.Explanation,
  r.IsActive,
  rd.LawArticle,
  rd.LastRevizedDate,
  rd.RegulationLink,
  rd.Explanation RegDetailExplanation
from TblRegulation r
  left outer join TblRegulationDetail rd on rd.RegulationID=r.RegulationID


GO
/****** Object:  Table [dbo].[TblType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblType](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeCategory] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblType] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TypeDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_TypeDetail] 
AS select 
  td.TypeDetailID,
  td.TypeID,
  t.TypeCategory,
  t.Explanation TypeDesc,
  
  td.TypeName,
  td.EffectStrength
  from TblTypeDetail td WITH (NOLOCK)
  left outer join TblType t WITH (NOLOCK) on t.TypeID = td.TypeID

GO
/****** Object:  View [dbo].[View_1]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        pl.LocationID AS locationID, AVG(realize.TotalPoint) AS AveragePoint
FROM            dbo.TblAuditRealize AS realize INNER JOIN
                         dbo.TblAuditPlan AS pl ON realize.AuditPlanID = pl.AuditPlanID
GROUP BY pl.LocationID

GO
/****** Object:  Table [dbo].[TedarikUrun]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TedarikUrun](
	[TedarikName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[CatID] [int] NULL,
	[MaterialName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[ProviderID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TEdarikciKarsilastirma]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[V_TEdarikciKarsilastirma]
as
select distinct p.ProviderID as providerID,u.TedarikName as TedarikName,p.Name as ProviderName,u.MaterialName as MatName,
u.CatID as CatID from TedarikUrun as u WITH (NOLOCK) left outer join TblProvider as p WITH (NOLOCK) on u.TedarikName=p.Name
 
GO
/****** Object:  View [dbo].[V_LocationInfo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 6.12.2018
Explanation : Mutfak Bilgisi
*/

CREATE VIEW [dbo].[V_LocationInfo] AS

SELECT L.LocationID,L.LocationName,VR.Name AS VirtualRegion,TD.TypeName AS ProjectType
FROM [NetAuditDB].[dbo].TblLocation L 
LEFT JOIN [NetAuditDB].[dbo].TblVirtualRegion VR ON VR.VirtualRegionID = L.RegionID
LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail TD ON TD.TypeDetailId = L.LocationTypeID
GO
/****** Object:  View [dbo].[V_ManagerOfLocations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 16.11.2018, 19.09.2019
Explanation : Mutfakların Yöneticileri ve Pozisyonları, ADI SOYADI EKLENDİ
*/

CREATE VIEW [dbo].[V_ManagerOfLocations] AS
SELECT 
EL.LocationID,
E.Name,E.Surname,R.RoleName, 
e.name + ' ' + e.surname as "ADI SOYADI"
FROM [NetAuditDB].[dbo].TblEmployeeLocation AS EL WITH (NOLOCK)
LEFT JOIN [NetAuditDB].[dbo].TblEmployee AS E WITH (NOLOCK) ON E.EmployeeID = EL.EmployeeID
LEFT JOIN [NetAuditDB].[dbo].TblRoles AS R WITH (NOLOCK) ON R.RoleID = E.PositionRoleID
WHERE E.IsActive = 1
GO
/****** Object:  View [dbo].[V_PleasureView]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
0 First Release Date : 27.08.2019
0 Explanation : Şikayetler için oluşturulmuş Viewdir. 252 ip'den veri çekmelidir. PowerBI tarafından veriler görüntülenebilir.
*/




CREATE View [dbo].[V_PleasureView] as 









select 
p.PleasureID
,LcoationID
,pi.IntoxicationID
,pp.PleasureProviderID
,ProjectMannager as "Proje Yöneticisi"
,ProjectMannagerMission as "Proje Yöneticisi Görevi"
,CustomerMannagementName as "İdari İşler Yetkilisi Adı-Soyadı"
,CusManPhone as "İdari İşler Yetkilisi Telefon No"
,case
	when CusManIsInfo=1 then 'Evet'
	when CusManIsInfo=0 then 'Hayır'
	else 'Error Cusmanisinfo' end as 'İdari İşler Sorumlusu Şikayet Hakkında Bilgi Sahibi mi?'
,PleasuredPersonelName as "Şikayet Edenin Adı-Soyadı"
,PleaPerMission as "Şikayet Edenin Görevi"
,PleaPerPhone as "Telefon Numarası"

,case
	when p.PleasureType=1 then 'GZB'
	when p.PleasureType=0 then 'MŞB'
	else 'Error GZB/MŞB' end as 'MŞB/GZB'

,CASE /*Tedarikçi Kaynaklı mı Mutfak Kaynaklı mı?*/
	WHEN [PleasureSource] = 1 then 'TEDARİKÇİ'
	WHEN [KitchenSourceType] =1 THEN 'MERKEZ MUTFAK'
	WHEN [KitchenSourceType] =2 THEN 'TAŞIMA MUTFAK'
	WHEN [KitchenSourceType] =3 THEN 'YERİNDE MUTFAK' 
	ELSE 'Error Sebeb Yeri' END AS 'Sorumlu Mutfak'

,CASE
	when PleasuredLevelInstant=1 Then 'Anlık'
	when PleasuredLevelImmediate=1 Then 'Acil'
	when PleasuredLevelRoutine=1 Then 'Rutin'
	when PleasuredLevelCritical=1 Then 'Kritik'
	else 'Error Şikayet Sevisei' end as 'Şikayet Seviyesi'


,PleasureExplanation as "Şikayeti Açıklayınız"
,FirtFeedBack as "Müşteriye Verilen İlk Bilgi"

,case
	when FeedBackType=1 then 'Yazılı'
	when FeedBackType=0 then 'Sözlü'
	else 'Error İlk Dönüş' end as 'Müşteriye İlk Dönüş Şekli?'

,FeedBackPersonelName
,CustomerReaction as "Müşterinin İlk Tepkisi"
,CloseDate as "Şikayetin Kapatılma Tarihi"

,Case
	when ReturnType=0 Then 'Sözlü'
	when ReturnType=1 Then 'Yazılı'
	else 'Müşteriye Dönüş Şekli girilmemiş' end as 'Müşteriye Dönüş Şekli?'

,ReturnedPersonel

,case
	when CustomerPleasure=1 then 'Evet'
	when CustomerPleasure=0 then 'Hayır'
	else 'Error Şikayetin Kapatılması' end as "Müşteri Memnun Kaldı Mı?"

,case
	when p.IsActive=1 then 'Açık'
	when p.IsActive=0 then 'Kapalı'
	else 'Şikayet Durumu Boş' end as 'Şikayet durumu'

,PleasureDate as "Şikayet Tarihi"
,ReturnCusDate as "Müşteriye Dönüş Tarihi"
,ProjectManPhone as "Proje Yöneticisi Telefon"
,DeliveName as "İletim Şekli"
,PleasureExp as "Yardımcı Açıklama"
,SubstanceName as "Şikayet Kaynağı"
--,CustomerReturnClaim 
,SpokenReturnExp as "Sözlü Dönüş"
,FirstReturnCorrection as "Yapılan Düzeltme"
,SekondReturnPerID as "2.Dönüş Yapan Personel"
,SecondReturnDate as "2.Dönüş Tarihi"
,ThirdReturnPerID as "3.Dönüş Yapan Personel"
,ThirdReturnDate as "3.Dönüş Tarihi"
,PleasureCreateDate as "Şikayet Oluşturma Tarihi"

,case
	when SecondTurnType=0 then 'Sözlü'
	when SecondTurnType=1 then 'Yazılı'
	Else '2. Dönüş Bilgisi bulunmamaktadır' end as 'Müşteriye 2. Dönüş Şekli'

,SecondTurnInfo as "Müşteriye Yapılan 2.Dönüş"

,case
	when ThirdTurnType=0 then 'Sözlü'
	when ThirdTurnType=1 then 'Yazılı'
	Else '3. Dönüş Bilgisi bulunmamaktadır' end as 'Müşteriye 3. Dönüş Şekli'

,ThirdTurnInfo as "Müşteriye Yapılan 3.Dönüş"
--,PleasureStatue
,PleasureNo as "Şikayet No"

,case
	when p.Cancel=1 then 'Aktif'
	when p.Cancel=0 then 'Pasif'
	else 'Error Aktif/Pasif' end as 'Şikayet Aktif mi?'

--,CloseUpdate

,case
	when pi.SapmleProduct=1 then 'Evet'
	when pi.SapmleProduct=0 then 'hayır'
	else 'Bilgi Yok' end as 'Ürünlerin Şahitn Numuneleri Var mı?'
	
,MissingProduct as "Eksik Olanları Yazınız"
--,CustomerEvidences 

,case
	when pi.SymptonsVomit=1 then 'Evet'
	when pi.SymptonsVomit=0 then 'Hayır'
	else 'Bilgi Yok' end as 'Semptom Kusma'

,case
	when pi.SymptonsFever=1 then 'Evet'
	when pi.SymptonsFever=0 then 'Hayır'
	else 'Bilgi Yok' end as 'Semptom Ateş'

,case
	when pi.SymptonsSickness=1 then 'Evet'
	when pi.SymptonsSickness=0 then 'Hayır'
	else 'Bilgi Yok' end as 'Semptom M.Bulantısı'

,case
	when pi.SymptonsRuns=1 then 'Evet'
	when pi.SymptonsRuns=0 then 'Hayır'
	else 'Bilgi Yok' end as 'Semptom İshal'

,case
	when pi.SymptonsStomachAche=1 then 'Evet'
	when pi.SymptonsStomachAche=0 then 'Hayır'
	else 'Bilgi Yok' end as 'Semptom K.Ağrısı'

,OtherSymptons as "Diğer Belirtiler"
,CustomerEffect as "GZB Kişi Sayısı"
,CustomerNumber  as "Yemeği Tüketen Kişi Sayısı"
,EatDate as "Tüketilen Tarih/Saat"
,SymptonsInfo as "Belirtiler Ne Zaman Başladı"

,WentDoctor as "Müşteri Doktora Gitti mi? Sonuç ?"
,PublicFoods as "Şikayeti Olan Müşterilerin Ortak Tükettikleri Yemekler"

,case
	when pi.IsSameDepartman=1 then 'Evet'
	when pi.IsSameDepartman=0 then 'Hayır'
	else 'Error Aynı Departman' end as 'Aynı Departmanda Çalışıyorlar?'

,OtherEatFoods as "Şikayetçinin Varsa Başka Tükettiği Yemekler"
,OtherParty as "Şikayetçinin Katıldığı Özel Toplantı,Parti vb..."
,Day as "Gün"
,MealsTime as "Öğün"
,ProblemType as "Problemin türü"
,ProblemExplanation as "Problemi Tanımlayınız"
,ProductInformations as"Etiket Bilgileri "
,pro.Name as "Tedarikçi Adı"
,prc.Name as "Kök Neden"
,mol.RoleName as 'Rol'
,mol.[ADI SOYADI] as 'Mutfağın bağlı olduğu Yönetici Adı'
,li.LocationName
,li.ProjectType as 'Mutfak Tipi'
,li.VirtualRegion as 'Sanal Bölge'

from [NetAuditDB].[dbo].TblPleasure as p
left join [NetAuditDB].[dbo].TblPleasureDeliverType as pdt on pdt.DeliverID=p.DeliverID
left join [NetAuditDB].[dbo].TblPleasureExplanationHelp as peh on peh.PleasureExpID=p.PleasureExpID
left join [NetAuditDB].[dbo].TblPleasureForeignSubstance as pfs on pfs.Substance=p.substanceID
left join [NetAuditDB].[dbo].TblPleasureIntoxication as pi on pi.PleasureID=p.PleasureID
left join [NetAuditDB].[dbo].TblPleasureProvider as pp on pp.PleasureID=p.PleasureID
left join [NetAuditDB].[dbo].TblProvider as pro on pro.ProviderID=pp.ProviderId
left join [NetAuditDB].[dbo].TblPleasureRootCause as prc on prc.RootCauseID=p.RootCauseID
--full join TblPleasureActions as pa on pa.PleasureID=p.PleasureID /* şikayetin ilk giriş mi güncelleme mi olduğunun tarihli bilgisini içeren tablodur*/

inner join [dbo].[V_LocationInfo] as li on li.LocationID=p.LcoationID
inner join [dbo].[V_ManagerOfLocations] as mol on mol.LocationID=p.LcoationID


where p.PleasureDate >='2018-06-01'
GO
/****** Object:  View [dbo].[V_PowerBI_Audit&Control]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 23.11.2018
Explanation : Denetim/Kontrol Durumu (AP.AuditDate durumu planlama tarihi içerir. Eğer gerçekleşme tarihi istenirse AR.AuditDate kullanılması gerekir)
*/

CREATE VIEW [dbo].[V_PowerBI_Audit&Control] AS

SELECT
AR.AuditRealizeID,
A.AuditorID,
AAP.AuditorAuditPlanID,
AP.AuditPlanID,
AP.AuditDate,
AT.TypeName,
AP.AuditOHS,
L.LocationID,
L.LocationName,
L.IsActive AS LocationIsActive,
P.IsActive AS ProviderIsActive,
VR.Name AS VirtualName,
TD.TypeName AS ProjectType,
P.Name AS ProviderName,
P.ProviderID,
AP.IsAudited,
AP.IsActive,
E.Name + ' ' + E.Surname AS AuditorName,
ML.Name + ' ' + ML.Surname AS ManagerName,
ML.RoleName AS ManagerRole
FROM [NetAuditDB].[dbo].TblAuditRealize AS AR 
INNER JOIN [NetAuditDB].[dbo].TblAuditPlan AS AP WITH (NOLOCK) ON AP.AuditPlanID = AR.AuditPlanID
INNER JOIN [NetAuditDB].[dbo].TblAuditorAuditPlan AS AAP WITH (NOLOCK) ON AAP.AuditPlanID = AP.AuditPlanID /*Denetim Sayısını TblAuditorAuditPlan distinct edilerek elde edilir*/
LEFT JOIN [NetAuditDB].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID = AP.LocationID
LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail AS  TD WITH (NOLOCK) ON TD.TypeDetailId = L.LocationTypeID
LEFT JOIN [NetAuditDB].[dbo].TblVirtualRegion AS VR WITH (NOLOCK) ON VR.VirtualRegionID = L.RegionID
LEFT JOIN [NetAuditDB].[dbo].TblProvider AS P WITH (NOLOCK) ON P.ProviderID = AP.ProviderID
LEFT JOIN [NetAuditDB].[dbo].TblAuditType AS AT WITH (NOLOCK) ON AT.AuditTypeID = AP.AuditTypeID
LEFT JOIN [NetAuditDB].[dbo].TblAuditor AS A WITH (NOLOCK) ON AAP.AuditorID = A.AuditorID
LEFT JOIN [NetAuditDB].[dbo].TblEmployee AS E WITH (NOLOCK) ON A.EmployeeID = E.EmployeeID 
LEFT JOIN V_ManagerOfLocations AS ML WITH (NOLOCK) ON ML.LocationID = AP.LocationID


WHERE AAP.IsRealized = 1
GO
/****** Object:  View [dbo].[V_PowerBI_AuditPoints]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 30.11.2018
Explanation : Denetim/Kontrol Puanları 
*/

CREATE VIEW [dbo].[V_PowerBI_AuditPoints] AS

SELECT
/*ID'ler*/
AR.AuditPlanID,
AR.AuditRealizeID,
Ap.AuditDate,AP.LocationID,AP.ProviderID,AT.TypeName,AP.IsAudited,
E.Name+' '+E.Surname AS AuditorName,
P.Name AS ProviderName,L.LocationName,TD.TypeName AS ProjectType,V.Name,
MOL.Name+' '+MOL.Surname AS ManagerName,
/*Puanlar*/ 
AR.TotalPoint, 
AR.TotalProcessPoint,
AR.TotalTechPoint,
AR.TotalInfraPoint,
AR.MajorPoint,
AR.HandSamplePoint,
AR.ItemSamplePoint, 
AR.ProcesTecnicPoint, 
AR.ProcesInfraPoint,
AR.InfraMajorPoint,
AR.TechMajorPoint,
AR.QualityPoint,
AP.AuditOHS
FROM [NetAuditDB].[dbo].TblAuditRealize AS AR WITH (NOLOCK)
INNER JOIN  [NetAuditDB].[dbo].TblAuditPlan AS AP WITH (NOLOCK) ON AR.AuditPlanID=AP.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditType AS AT WITH (NOLOCK) ON AT.AuditTypeID = AP.AuditTypeID 
LEFT JOIN [NetAuditDB].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID= AP.LocationID
LEFT JOIN [NetAuditDB].[dbo].TblVirtualRegion AS V WITH (NOLOCK) ON L.RegionID=V.VirtualRegionID
LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail AS TD WITH (NOLOCK)  ON L.LocationTypeID = TD.TypeDetailId
LEFT JOIN [NetAuditDB].[dbo].TblAuditorAuditPlan AS AAP WITH (NOLOCK) ON AP.AuditPlanID =AAP.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditor AS A WITH (NOLOCK) ON A.AuditorID =AAP.AuditorID
LEFT JOIN [NetAuditDB].[dbo].TblEmployee AS E WITH (NOLOCK) ON A.EmployeeID =E.EmployeeID
LEFT JOIN [NetAuditDB].[dbo].TblProvider AS P WITH (NOLOCK) ON P.ProviderID = AP.ProviderID
LEFT JOIN [dbo].V_ManagerOfLocations AS MOL WITH (NOLOCK) ON MOL.LocationID = AP.LocationID
GO
/****** Object:  View [dbo].[V_PowerBI_AuditRealizeMajor]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 6.12.2018
Explanation : Major Hatalar
*/

CREATE VIEW [dbo].[V_PowerBI_AuditRealizeMajor] AS
SELECT 
AR.AuditRealizeID,
ARD.LevelID,
AP.AuditPlanID,
AP.AuditDate,
ARD.AudReDetID,
AT.TypeName,
LI.LocationID,LI.LocationName,LI.VirtualRegion AS VirtualRegion,LI.ProjectType,
E.Name + ' ' +E.Surname AS AuditorName,
Concat(ARD.Explanation,(select STRING_AGG(ARD1.Explanation,'//')

from [NetAuditDB].[dbo].TblTempGroupMajor TEMP1
inner JOIN [NetAuditDB].[dbo].TblAuditRealizeDetail ARD1 on ARD1.AudReDetID = TEMP1.AuditReDetID 
where TEMP1.AuditPlanID = AP.AuditPlanID and TEMP1.GroupID = q.QuestionID
group by TEMP1.GroupID)) Explanation,
ARD.FirstResponsible,ARD.SecondResponsible,ARD.ThirdResponsible,
MG.MajorGroupName, LD.SubLevelName AS MajorName,R.RegulationName,
ML.Name + ' ' + ML.Surname AS ManagerName, ML.RoleName AS ManagerRole
FROM [NetAuditDB].[dbo].TblAuditRealize AR WITH (NOLOCK)
INNER JOIN [NetAuditDB].[dbo].TblAuditPlan AS AP WITH (NOLOCK) ON AR.AuditPlanID = AP.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditType AS AT WITH (NOLOCK) ON AT.AuditTypeID = AP.AuditTypeID 
LEFT JOIN [NetAuditDB].[dbo].TblAuditorAuditPlan AAP WITH (NOLOCK) ON AAP.AuditPlanID=AP.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditor A WITH (NOLOCK) ON A.AuditorID = AAP.AuditorID
LEFT JOIN [NetAuditDB].[dbo].TblEmployee E WITH (NOLOCK) ON E.EmployeeID = A.EmployeeID
LEFT JOIN [NetAuditDB].[dbo].TblAuditRealizeDetail ARD WITH (NOLOCK) on ARD.AuditPlanID=AR.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblQuestion Q WITH (NOLOCK) on ARD.QuestionID=Q.QuestionID
LEFT JOIN [NetAuditDB].[dbo].TblLevelDetail LD WITH (NOLOCK) on LD.LevelDetailID=ARD.LevelID
LEFT JOIN [NetAuditDB].[dbo].TblRegulation as R WITH (NOLOCK) on R.RegulationID=ARD.RegulationID
LEFT JOIN [NetAuditDB].[dbo].TblMajorGroup as MG WITH (NOLOCK) on MG.MajorGroupID=ARD.MajorGroupID

LEFT JOIN V_LocationInfo LI ON LI.LocationId = AP.LocationId
LEFT JOIN V_ManagerOfLocations ML ON ML.LocationID =AP.LocationId

WHERE ARD.LevelID IS NOT NULL AND AP.LocationID IS NOT NULL
GO
/****** Object:  View [dbo].[V_PowerBI_ProviderConformities]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 18.10.2018
Date2 : 09.09.2019
Explanation : Tedarikçi Uygunsuzlukları
Revision : Surrebutter included. 
*/



CREATE VIEW [dbo].[V_PowerBI_ProviderConformities] AS
SELECT
PP.ProviderID,
PP.ProviderProblemID,
CompanyName = P.Name,
KitchenName = CASE WHEN LI.LocationID IS NULL THEN DEP.DepartmentName ELSE LI.LocationName END,
LI.ProjectType,LI.VirtualRegion,
DeterminationDate,
IsProduct=CASE ProblemType WHEN 1 THEN 1 END,
IsService=CASE ProblemType WHEN 0 THEN 1 END,
PP.Explantion,
TagInfo=NULL,
MAJOR = CASE MajorError WHEN 1 THEN 1 END,
MINOR = CASE WHEN MajorError IS NULL OR MajorError = 0 THEN 1 END,
YMNumber = CASE WHEN YMNumber != 0 THEN YMNumber ELSE 0 END,
TD.TypeName,
PP.MSB,
pp.Surrebutter,
PEH.PleasureExp,
Result

  FROM [NetAuditDB].[dbo].[TblProviderProblem] PP WITH (NOLOCK)
	INNER JOIN [NetAuditDB].[dbo].TblProvider AS P WITH (NOLOCK) ON P.ProviderID = PP.ProviderID
	LEFT JOIN [NetAuditDB].[dbo].TblProviderProblemImpurityRelationship AS PIR WITH (NOLOCK) ON PIR.ProviderProblemID = PP.ProviderProblemID  
    LEFT JOIN [NetAuditDB].[dbo].TblPleasureExplanationHelp AS PEH WITH (NOLOCK) ON PEH.PleasureExpID = PIR.ImpurityID
	LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail AS TD WITH (NOLOCK) ON TD.TypeDetailId = PP.ProblemReasonID
	LEFT JOIN V_LocationInfo LI WITH (NOLOCK) ON LI.LocationID = PP.LocationID
	LEFT JOIN TblDepartment DEP WITH (NOLOCK) ON PP.DepartmentId = DEP.DepartmentID
	WHERE PP.IsActive = 1
GO
/****** Object:  View [dbo].[V_PowerBI_PublishLocationPointOld]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 12.02.2019
Explanation : AYLIK HİJYEN DENETİM PUANI
*/



CREATE VIEW [dbo].[V_PowerBI_PublishLocationPointOld] AS
SELECT DISTINCT 
V.LocationID,
L.LocationName,
TD.TypeDetailId,
TD.TypeName,
MOL.Name +' ' + MOL.Surname AS ManagerName,
MOL.RoleName,
V.YearID,
V.MonthID,
V.auditPoint,
V.CheckListPoint,
V.QualityPoint,
V.handPoint,
V.devicePoint,
V.majorPoint,
VR.VirtualRegionID,
VR.Name as "VirtualRegion"
from [NetAuditDB].[dbo].[V_AvveragePublishLocationPoints] AS V WITH (NOLOCK)
INNER JOIN [NetAuditDB].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID= V.LocationID
INNER JOIN [NetAuditDB].[dbo].TblVirtualRegion AS VR WITH (NOLOCK) ON L.RegionID=VR.VirtualRegionID
INNER JOIN [NetAuditDB].[dbo].TblTypeDetail AS TD WITH (NOLOCK)  ON L.LocationTypeID = TD.TypeDetailId
INNER JOIN [dbo].V_ManagerOfLocations AS MOL WITH (NOLOCK) ON MOL.LocationID = V.LocationID
Where V.YearID= YEAR(GETDATE()-15)
GO
/****** Object:  View [dbo].[V_PowerBI_PublishLocationPoint_ForAverage]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[V_PowerBI_PublishLocationPoint_ForAverage] AS
SELECT DISTINCT 
V.LocationID,
L.LocationName,
TD.TypeDetailId,
TD.TypeName,
V.YearID,
V.MonthID,
V.auditPoint,
V.CheckListPoint,
V.QualityPoint,
V.handPoint,
V.devicePoint,
V.majorPoint,
VR.Name as "VirtualRegion"
from [SARDUNYADBNEW].[dbo].[V_AvveragePublishLocationPoints] AS V WITH (NOLOCK)
INNER JOIN [SARDUNYADBNEW].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID= V.LocationID
INNER JOIN [SARDUNYADBNEW].[dbo].TblVirtualRegion AS VR WITH (NOLOCK) ON L.RegionID=VR.VirtualRegionID
INNER JOIN [SARDUNYADBNEW].[dbo].TblTypeDetail AS TD WITH (NOLOCK)  ON L.LocationTypeID = TD.TypeDetailId
where V.YearID= YEAR(GETDATE()) OR V.YearID = YEAR(GETDATE())-1
GO
/****** Object:  View [dbo].[V_PowerBI_RiskAssessment]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
Date : 17.09.2019
Explanation : İSG BİRİMİ TARAFINDAN OLUŞTURULAN RİSK DEĞERLENDİRME VERİLERİNİN POWERBI İÇİN OLUŞTURULMUŞ VIEWDİR.
*/


CREATE VIEW [dbo].[V_PowerBI_RiskAssessment] AS 


SELECT 
 
ratl.RiskAssessmentLocID,
rat.RiskAssessmentID,
l.LocationName,
l.LocationID,
LI.VirtualRegion AS "Sanal Bölge",
LI.ProjectType as "Proje Tipi",
ratl.Date as "Ziyaret Tarihi",
ratl.ValidityDate as "Geçerlilik Tarihi",
ohsexp.Name + ' ' + ohsexp.Surname as "İSG Uzmanı",
ratl.AnalyzedUnit as "Birim",
analy.Name + ' ' + analy.Surname as "Analizi Yapan",
emplo.Name + ' ' + emplo.Surname as "İşveren Vekili",
doct.Name + ' ' + doct.Surname as "İşyeri Hekimi",
 
CASE When RATL.SupportElement is not null THEN RATL.SupportElement
       WHEN RATL.SupportElement is null then suppo.Name + ' ' + suppo.Surname
       END AS "Destek Personel",
 
CASE When RATL.EmployeeRepresentative is not null      THEN RATL.EmployeeRepresentative
       WHEN RATL.EmployeeRepresentative is null then repremp.Name + ' ' + repremp.Surname
       END AS "Çalışan Temsilcisi",

ratl.IsActive as "Risk Değerlendirme Aktif mi?",
l.IsActive as "Mutfak Açık mı?",
process.TypeName as "İşlem Basamağı/Bölüm",
danger.DangerSourceExplanation as "Tehlike Kaynağı",
status.Explanation as "Tehlikeli Durum",
risk.Explanation as "Risk",
affect.TypeName as "Etkilenecek Kişiler",
rat.ProbabilityValue as "Olasılık",
rat.ViolenceValue as "Şiddet",
rat.RiskValue as "Risk Değeri",
rat.RiskTolere as "Risk Seviyesi",
rat.Responsible as "Sorumlu",
rat.Termin as "Termin",
rat.RealizeDate as "Gerçekleştirildiği Tarih",
rat.RealizeProbabilityValue as "Son Durum Olasılık",
rat.RealizeViolenceValue as "Son Durum Şiddet",
rat.RealizeRiskValue as "Son Durum Risk Değeri",
rat.RealizeRiskTolere as "Son Durum Risk Seviyesi",
--cp.ControlPreventionExplanation as "Ek Kontrol Önlemi",
--cppre.ControlPreventionExplanation as "Mevcut Kontrol Önlemi",
ML.Name + ' ' + ML.Surname AS "Mutfak Yöneticileri", 
ML.RoleName as "Yönetici Rolü"

  FROM [NetAuditDB].[dbo].[TblOHSRiskEssesmentTableLocation] as ratl WITH (NOLOCK)
  inner join.[NetAuditDB].[dbo].TblLocation as l WITH (NOLOCK) on l.LocationID=ratl.LocationID
  inner join.[NetAuditDB].[dbo].TblOHSRiskAssessmentTable as rat WITH (NOLOCK) on rat.RiskAssessmentLocID=ratl.RiskAssessmentLocID
  full join [NetAuditDB].[dbo].TblOHSRiskSupportEmployeeRelations as support WITH (NOLOCK) on support.RiskAssessmentLocID=ratl.RiskAssessmentLocID
  full join [NetAuditDB].[dbo].TblEmployee as suppo WITH (NOLOCK) on suppo.EmployeeID=support.EmployeeID
  full join [NetAuditDB].[dbo].TblOHSRiskRepresentativeEmployeeRelation as repre WITH (NOLOCK) on repre.RiskAssessmentLocID=ratl.RiskAssessmentLocID
  full join [NetAuditDB].[dbo].TblEmployee as repremp WITH (NOLOCK) on repremp.EmployeeID=repre.EmployeeID
  inner join [NetAuditDB].[dbo].TblEmployee as ohsexp WITH (NOLOCK) on ohsexp.EmployeeID=ratl.OHSExpertEmployeeID
  inner join [NetAuditDB].[dbo].TblEmployee as analy WITH (NOLOCK) on analy.EmployeeID=ratl.AnalyticalEmployeeID
  inner join [NetAuditDB].[dbo].TblEmployee as emplo WITH (NOLOCK) on emplo.EmployeeID=ratl.EmployerID
  inner join [NetAuditDB].[dbo].TblEmployee as doct WITH (NOLOCK) on doct.EmployeeID=ratl.DoctorEmployeID
  left join [NetAuditDB].[dbo].TblOHSDangerSource as danger WITH (NOLOCK) on danger.DangerSourceID=rat.DangerSourceID
  left join [NetAuditDB].[dbo].TblOHSDangerStatus as status WITH (NOLOCK) on status.DangerStatusID=rat.DangerStatusID
  left join [NetAuditDB].[dbo].TblTypeDetail as process WITH (NOLOCK) on process.TypeDetailId=rat.ProcessStepID
  left join [NetAuditDB].[dbo].TblTypeDetail as affect WITH (NOLOCK) on affect.TypeDetailId=rat.PersonsAffectedID
  left join [NetAuditDB].[dbo].TblOHSRisk as risk WITH (NOLOCK) on risk.RiskID=rat.RiskID

  left join [NetAuditDB].[dbo].TblOHSAdditionalPreventionRiskAssessRelations as apar WITH (NOLOCK) on apar.RiskAssessmentID=rat.RiskAssessmentID
  left join [NetAuditDB].[dbo].TblOHSControlPrevention as cp WITH (NOLOCK) on cp.ControlPreventionID=apar.ControlPreventionID

  left join [NetAuditDB].[dbo].TblOHSPreventionRiskAssessRelations as prar WITH (NOLOCK) on prar.RiskAssessmentID=rat.RiskAssessmentID
  left join [NetAuditDB].[dbo].TblOHSControlPrevention as cppre WITH (NOLOCK) on cppre.ControlPreventionID=prar.ControlPreventionID

  LEFT JOIN V_ManagerOfLocations AS ML WITH (NOLOCK) ON ML.LocationID = ratl.LocationID
  LEFT JOIN V_LocationInfo LI WITH (NOLOCK) ON LI.LocationId = ratl.LocationID
GO
/****** Object:  View [dbo].[V_ProviderAuditRealizeCorrectiveActivity]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_ProviderAuditRealizeCorrectiveActivity] AS

	SELECT 
			auditPlan.AuditPlanID AS AuditPlanID,
			auditPlan.AuditDate AS AuditDate,
			auditType.TypeName AS AuditType,
			audit.AuditName AS Audit,
			location.Name AS ServiceName,
			CASE WHEN (auditRealize.UnsuitabilityStatue IS NULL OR auditRealize.UnsuitabilityStatue=1) THEN 'true' ELSE 'false' END AS UnsuitabilityStatue,
			CASE WHEN (SELECT COUNT(*) FROM TblAuditRealizeDetail WHERE AuditPlanID = auditPlan.AuditPlanID AND IsRegulatoryActivity = 1 AND ConfirmActionStatue != 1)>0 then 'true' else 'false' end AS CorrectiveActivityStatue,
			CASE WHEN (SELECT dbo.FN_HandAndDeviceUnCorrectiveCount(auditPlan.AuditPlanID))>0 THEN 'true' ELSE 'false' END AS HandAndDevice
	FROM 
			   dbo.TblAuditRealize     AS auditRealize 
	INNER JOIN TblAuditPlan        AS auditPlan    on auditPlan.AuditPlanID=auditRealize.AuditPlanID
	INNER JOIN TblProvider         AS location     on auditPlan.ProviderID = location.ProviderID
	INNER JOIN TblAuditType        AS auditType    on auditPlan.AuditTypeID = auditType.AuditTypeID
	INNER JOIN TblAudit            AS audit        on auditPlan.AuditID = audit.AuditID
	INNER JOIN TblAuditorAuditPlan AS auditorplan  on auditPlan.AuditPlanID = auditorplan.AuditPlanID
	
GO
/****** Object:  View [dbo].[V_PowerBI_Unsuitability]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
0 First Release Date : 02.08.2019
1 Revision Date : 22.08.2019
0 Explanation : Uygunsuzlukların PowerBI dosyasından erişilebilmesi için oluşturulmuştur. 
1 Explanation : Status eklendi. full join [192.168.1.252].[SARDUNYADBNEW].[dbo].TblLevelDetail as ld on ld.LevelDetailID=ard.levelid düzeltildi. 
*/


CREATE VIEW [dbo].[V_PowerBI_Unsuitability] as


SELECT 
ap.AuditPlanID,
ard.questionID,
l.LocationName,
ap.AuditDate,
case 
	when ap.AuditOHS = 0 then 'ISGDEGIL'
	when ap.AuditOHS = 1 then 'ISG'
	else 'HATAISG' 
	end as 'ISGMI?',
q.QDefination,
ard.explanation, 
CASE
    WHEN ard.ProcessPoint= ard.TechnicalPoint THEN 'Altyapı'
    WHEN ard.ProcessPoint= ard.InfrastructurePoint THEN 'Teknik'
    WHEN ard.TechnicalPoint= ard.InfrastructurePoint THEN 'Uygulama'
    ELSE '----'
END AS 'Status',
ld.SubLevelName,
case 
	when ard.IsRegulatoryActivity = 0 then 'MINOR'
	when ard.IsRegulatoryActivity = 1 then 'MAJOR'
	else 'HATAMAJOR' 
	end as 'SEVIYE?',

case 
	when ard.IsNonAudit = 0 then 'DENETIMICI'
	when ard.IsNonAudit = 1 then 'DENETIMDISI'
	else 'HATADD' 
	end as 'DENETIMDISI?',
at.TypeName,
td.TypeName as MutfakGrup,
vr.Name,
td1.TypeName Soru,
e.Name + ' ' + e.Surname as DENETCI,
i.SetID as SETID,
s.SetName as SetName,
--m.GroupMajorID as MajorGroupID,
--g.MajorGroupName as MajorGroupName,
--g.MajorGroupExplanation as MajorGroupExplanation,
q.Section as Section,
e.Name + ' ' + e.Surname AS AuditorName,
E2.Name +' '+ E2.Surname AS ManagerName,
E2.DepartmentID AS DepartmentID,
d.DepartmentName as DepartmentName









FROM [SARDUNYADBNEW].[dbo].TblAuditPlan as ap WITH (NOLOCK)

inner join [SARDUNYADBNEW].[dbo].TblAuditRealizeDetail as ard WITH (NOLOCK) on ard.AuditPlanID=ap.AuditPlanID
--full join [192.168.1.252].[SARDUNYADBNEW].[dbo].TblLevel as le on le.EvidenceLevelId=ard.LevelID
full join [SARDUNYADBNEW].[dbo].TblLevelDetail as ld WITH (NOLOCK) on ld.LevelDetailID=ard.LevelID 
inner join [SARDUNYADBNEW].[dbo].TblAuditType as at WITH (NOLOCK) on at.AuditTypeID=ap.AuditTypeID 
inner join [SARDUNYADBNEW].[dbo].TblQuestion as q WITH (NOLOCK) on q.QuestionID=ard.QuestionID
inner join [SARDUNYADBNEW].[dbo].TblLocation as l WITH (NOLOCK) on l.LocationID=ap.LocationID
inner join [SARDUNYADBNEW].[dbo].TblTypeDetail as td WITH (NOLOCK) on td.TypeDetailId=l.LocationTypeID
inner Join [SARDUNYADBNEW].[dbo].TblTypeDetail as td1 WITH (NOLOCK) on td1.TypeDetailId=q.QuestionTypeID
inner join [SARDUNYADBNEW].[dbo].TblVirtualRegion as vr WITH (NOLOCK) on vr.VirtualRegionID=l.RegionID
inner join [SARDUNYADBNEW].[dbo].TblAuditorAuditPlan as aap WITH (NOLOCK) on aap.AuditPlanID=ap.AuditPlanID
inner join [SARDUNYADBNEW].[dbo].TblAuditor as a WITH (NOLOCK) on a.AuditorID=aap.AuditorID
inner join [SARDUNYADBNEW].[dbo].TblEmployee as e WITH (NOLOCK) on e.EmployeeID=a.EmployeeID
inner join [SARDUNYADBNEW].[dbo].TblQuestionSetItems as i WITH(NOLOCK) on q.QuestionID = i.QuestionID
inner join [SARDUNYADBNEW].[dbo].TblQuestionSet as s  WITH(NOLOCK) on i.SetID=s.SetID
--inner join [SARDUNYADBNEW].[dbo].TblTempGroupMajor as m WITH (NOLOCK) on m.QuestionID=q.QuestionID
--inner join [SARDUNYADBNEW].[dbo].TblMajorGroup as g WITH (NOLOCK) on g.MajorGroupID=m.GroupMajorID
--LEFT JOIN [SARDUNYADBNEW].[dbo].TblEmployee AS E1 WITH (NOLOCK) ON a.EmployeeID = E1.EmployeeID 
LEFT JOIN [SARDUNYADBNEW].[dbo].TblEmployeeLocation AS EL WITH (NOLOCK) ON EL.LocationID = l.LocationID
LEFT JOIN [SARDUNYADBNEW].[dbo].TblEmployee AS E2 WITH (NOLOCK) ON E2.EmployeeID = EL.EmployeeID
LEFT join [SARDUNYADBNEW].[dbo].TblDepartment as d WITH (NOLOCK) on d.DepartmentID=E2.DepartmentID










where
ard.Explanation is not null
GO
/****** Object:  View [dbo].[V_PowerBI_WorkAccidents]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 18.10.2018
Explanation : İş Kazaları, [dbo].[V_ManagerOfLocations] ile bağlandı. 
*/


CREATE VIEW [dbo].[V_PowerBI_WorkAccidents] AS
SELECT distinct
WA.WorkAccidentID AS Id,
WA.Date AS Date,
(DATENAME(W,WA.Date)) AS DayOfWeek,
L.LocationName AS ProjectName,
l.locationID,
TD.TypeName AS ProjectType,
VR.Name AS VirtualRegion,
D.DepartmentName AS Departmens,
SuperiorEmployees = STUFF((SELECT ','+ E.Name+ ' ' +E.Surname FROM [NetAuditDB].[dbo].TblEmployee E WHERE E.EmployeeID = WA.FirstSuperiorEmpID OR E.EmployeeID = WA.SecondSuperiorEmpID FOR XML PATH ('')),1,1,''),
SuperiorRoles = STUFF((SELECT ','+R.RoleName FROM [NetAuditDB].[dbo].TblEmployee E INNER JOIN [NetAuditDB].[dbo].TblRoles R ON R.RoleID = E.PositionRoleID WHERE E.EmployeeID = WA.FirstSuperiorEmpID OR E.EmployeeID = WA.SecondSuperiorEmpID FOR XML PATH ('')),1,1,''),
AccidentTypes = STUFF((SELECT ','+T.TypeName FROM [NetAuditDB].[dbo].TblOHSWorkAccidentTypeRelationship WATR  INNER JOIN [NetAuditDB].[dbo].TblTypeDetail T ON WATR.AccidentTypeID = T.TypeDetailId WHERE WATR.WorkAccidentID =WA.WorkAccidentID FOR XML PATH('')),1,1,''),
WA.Accidental, /*Kazanın oluş şekli*/
WA.AccidentRootCause AS RootCause,
WA.WorkingDayLoss AS DayLoss,
WA.WorkingHourLoss AS HourLoss,
mol.[RoleName],
mol.[ADI SOYADI],
CASE WHEN WA.MajorError = 0 THEN 1 WHEN WA.MajorError IS NULL THEN NULL END AS Minor,
CASE WHEN WA.MajorError = 1 THEN 1 WHEN WA.MajorError IS NULL THEN NULL END AS Major
FROM [NetAuditDB].[dbo].TblOHSWorkAccident WA WITH (NOLOCK)
left JOIN [NetAuditDB].[dbo].TblLocation L WITH (NOLOCK) ON L.LocationID = WA.LocationID
left JOIN [NetAuditDB].[dbo].TblVirtualRegion VR WITH (NOLOCK) ON VR.VirtualRegionID = L.RegionID
left JOIN [NetAuditDB].[dbo].TblDepartment D WITH (NOLOCK) ON D.DepartmentID = WA.DepartmanID 
left JOIN [NetAuditDB].[dbo].TblTypeDetail TD WITH (NOLOCK) ON TD.TypeDetailId = L.LocationTypeID 
full join [V_ManagerOfLocations] as mol WITH (NOLOCK) on mol.LocationID=WA.LocationID
WHERE WA.[IsActive] = 1
GO
/****** Object:  Table [dbo].[TblLocationTypeAuditorCount]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationTypeAuditorCount](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[TypeDetailId] [int] NOT NULL,
	[AuditorCount] [int] NOT NULL,
 CONSTRAINT [PK_TblLocationTypeAuditorCount] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblQuestionSetType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuestionSetType](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[SetID] [int] NULL,
	[SetCategoryTypeID] [int] NULL,
 CONSTRAINT [PK_TblQuestionSetType] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_AuditPlanExcelData]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_AuditPlanExcelData]
AS
SELECT        lo.LocationID, lo.LocationName, pe.PeriodID, pe.Explanation AS PeriodName, pe.Period, co.AuditorCount, qs.SetID, qs.SetName, lo.LocationTypeID
FROM            dbo.TblLocation AS lo WITH (NOLOCK) INNER JOIN
                         dbo.TblTypeDetail AS typede WITH (NOLOCK) ON lo.LocationTypeID = typede.TypeDetailId INNER JOIN
                         dbo.TblGroupLocationTypeAssignment AS grlo WITH (NOLOCK) ON typede.TypeDetailId = grlo.TypeDetailID INNER JOIN
                         dbo.TblGroup AS gr WITH (NOLOCK) ON grlo.GroupID = gr.GroupID INNER JOIN
                         dbo.TblPeriod AS pe WITH (NOLOCK) ON gr.PeriodID = pe.PeriodID INNER JOIN
                         dbo.TblLocationTypeAuditorCount AS co WITH (NOLOCK) ON lo.LocationTypeID = co.TypeDetailId INNER JOIN
                         dbo.TblQuestionSetType AS qt WITH (NOLOCK) ON lo.LocationTypeID = qt.SetCategoryTypeID INNER JOIN
                         dbo.TblQuestionSet AS qs WITH (NOLOCK) ON qt.SetID = qs.SetID
WHERE        (lo.IsActive = 1)
GO
/****** Object:  View [dbo].[PowerBIPointPerLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View [dbo].[PowerBIPointPerLocation] as

select distinct
 v.LocationID,
 loc.LocationName,
 r.Name as "VirtualRegion",
 r.VirtualRegionID,
 d.TypeDetailId,
 d.TypeName,
v.YearID,
v.MonthID,
indicatorname,
indicatorvalue
from [dbo].[V_AvveragePublishLocationPoints] as v WITH (NOLOCK) inner join TblLocation as loc WITH (NOLOCK) on v.LocationID=loc.LocationID
left join  TblVirtualRegion as r WITH (NOLOCK) on r.VirtualRegionID=loc.RegionID
inner join TblTypeDetail as d WITH (NOLOCK) on loc.LocationTypeID=d.TypeDetailId
inner join TblEmployeeLocation as el WITH (NOLOCK) on v.LocationID=el.LocationID
cross apply
(
  select 'AuditPoint', v.auditPoint union all
  select 'CheckListPoint', v.CheckListPoint union all
  select 'QualityPoint',v.QualityPoint union all
  select 'MajorPoint',v.majorPoint I 
) c (indicatorname, indicatorvalue);



GO
/****** Object:  Table [dbo].[TblOHSDangerStatus]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSDangerStatus](
	[DangerStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Explanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[OHSRiskSourceID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSDangerStatus] PRIMARY KEY CLUSTERED 
(
	[DangerStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRisk]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRisk](
	[RiskID] [int] IDENTITY(1,1) NOT NULL,
	[Explanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[OHSRiskSourceID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSRisk] PRIMARY KEY CLUSTERED 
(
	[RiskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSControlPrevention]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSControlPrevention](
	[ControlPreventionID] [int] IDENTITY(1,1) NOT NULL,
	[ControlPreventionExplanation] [nvarchar](300) COLLATE Turkish_CI_AS NULL,
	[ControlAdditionalPrevention] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSControlMeasures] PRIMARY KEY CLUSTERED 
(
	[ControlPreventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSPreventionRiskAssessRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSPreventionRiskAssessRelations](
	[PreventionEssessReID] [int] IDENTITY(1,1) NOT NULL,
	[ControlPreventionID] [int] NULL,
	[RiskAssessmentID] [int] NULL,
 CONSTRAINT [PK_TblOHSPreventionRiskAssessRelations] PRIMARY KEY CLUSTERED 
(
	[PreventionEssessReID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRiskAssesDocumentRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRiskAssesDocumentRelations](
	[RiskAssessmentDocReID] [int] IDENTITY(1,1) NOT NULL,
	[OHSDocumentID] [int] NULL,
	[RiskAssessmentID] [int] NULL,
 CONSTRAINT [PK_TblOHSRiskAssesDocumentRelations] PRIMARY KEY CLUSTERED 
(
	[RiskAssessmentDocReID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRiskAssessmentTable]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRiskAssessmentTable](
	[RiskAssessmentID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessStepID] [int] NULL,
	[DangerSourceID] [int] NULL,
	[PersonsAffectedID] [int] NULL,
	[RiskTolere] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[RiskID] [int] NULL,
	[DangerStatusID] [int] NULL,
	[ProbabilityValue] [int] NULL,
	[ViolenceValue] [int] NULL,
	[RiskValue] [int] NULL,
	[Termin] [date] NULL,
	[Responsible] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[RealizeProbabilityValue] [int] NULL,
	[RealizeViolenceValue] [int] NULL,
	[RealizeRiskValue] [int] NULL,
	[RealizeDate] [datetime] NULL,
	[RealizeRiskTolere] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[RiskAssessmentLocID] [int] NULL,
	[Prevention] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[AdditionalPrevention] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblOHSRiskAssessmentTable] PRIMARY KEY CLUSTERED 
(
	[RiskAssessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRiskEssesmentTableLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRiskEssesmentTableLocation](
	[RiskAssessmentLocID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[Date] [date] NULL,
	[ValidityDate] [date] NULL,
	[OHSExpertEmployeeID] [int] NULL,
	[DocumentNnumber] [nvarchar](15) COLLATE Turkish_CI_AS NULL,
	[AnalyzedUnit] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[AnalyticalEmployeeID] [int] NULL,
	[EmployerID] [int] NULL,
	[DoctorEmployeID] [int] NULL,
	[SupportElement] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[EmployeeRepresentative] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CopyStatue] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSRiskEssesmentTableLocation] PRIMARY KEY CLUSTERED 
(
	[RiskAssessmentLocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSDocument]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSDocument](
	[OHSDocumentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[Path] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[DocumentID] [int] NULL,
	[DocumentType] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblOHSDocument] PRIMARY KEY CLUSTERED 
(
	[OHSDocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_OHSRiskAssmentTable]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_OHSRiskAssmentTable]
AS
SELECT        risktableloc.RiskAssessmentLocID, risktableloc.LocationID, risktableloc.Date, risktableloc.ValidityDate, risktableloc.OHSExpertEmployeeID, risktableloc.DocumentNnumber, risktableloc.AnalyzedUnit, risktableloc.EmployerID, 
                         risktableloc.DoctorEmployeID, risktable.RiskAssessmentID, risktable.ProcessStepID, risktable.RiskSourceID, risktable.PersonsAffectedID, risktable.RiskTolereID, risktable.RiskID, risktable.DangerStatusID, 
                         risktable.ProbabilityValue, risktable.ViolenceValue, risktable.RiskValue, risktable.Termin, risktable.RealizeRiskValue, risktable.RealizeViolenceValue, risktable.ReazlieRiskValue, risktable.RealizeDate, 
                         risktable.RealizeRiskTolereID, risktable.RiskAssessmentLocID AS Expr1, procstep.TypeDetailId, procstep.TypeID, procstep.TypeName, procstep.EffectStrength, dangersource.TypeDetailId AS Expr2, 
                         dangersource.TypeID AS Expr3, dangersource.TypeName AS Expr4, dangersource.EffectStrength AS Expr5, dangerstatus.DangerStatusID AS Expr6, dangerstatus.Explanation, dangerstatus.OHSRiskSourceID, 
                         dangerstatus.IsActive, risk.RiskID AS Expr7, risk.Explanation AS Expr8, risk.OHSRiskSourceID AS Expr9, risk.IsActive AS Expr10, pereffct.TypeDetailId AS Expr11, pereffct.TypeID AS Expr12, pereffct.TypeName AS Expr13, 
                         pereffct.EffectStrength AS Expr14, docrelation.RiskAssessmentDocReID, docrelation.OHSDocumentID, docrelation.RiskAssessmentID AS Expr15, doc.OHSDocumentID AS Expr16, doc.OHSDocumentExplanation, 
                         doc.IsActive AS Expr17, preriskre.PreventionEssessReID, preriskre.ControlPreventionID, preriskre.RiskAssessmentID AS Expr18, contpre.ControlPreventionID AS Expr19, contpre.ControlPreventionExplanation, 
                         contpre.ControlAdditionalPrevention, contpre.IsActive AS Expr20
FROM            dbo.TblOHSRiskEssesmentTableLocation AS risktableloc INNER JOIN
                         dbo.TblOHSRiskAssessmentTable AS risktable ON risktableloc.RiskAssessmentLocID = risktableloc.RiskAssessmentLocID LEFT OUTER JOIN
                         dbo.TblTypeDetail AS procstep ON risktable.ProcessStepID = procstep.TypeDetailId LEFT OUTER JOIN
                         dbo.TblTypeDetail AS dangersource ON risktable.RiskSourceID = dangersource.TypeDetailId LEFT OUTER JOIN
                         dbo.TblOHSDangerStatus AS dangerstatus ON risktable.DangerStatusID = dangerstatus.DangerStatusID LEFT OUTER JOIN
                         dbo.TblOHSRisk AS risk ON risktable.RiskID = risk.RiskID LEFT OUTER JOIN
                         dbo.TblTypeDetail AS pereffct ON risktable.PersonsAffectedID = pereffct.TypeDetailId LEFT OUTER JOIN
                         dbo.TblOHSRiskAssesDocumentRelations AS docrelation ON risktable.RiskAssessmentID = docrelation.RiskAssessmentID LEFT OUTER JOIN
                         dbo.TblOHSDocument AS doc ON docrelation.OHSDocumentID = doc.OHSDocumentID LEFT OUTER JOIN
                         dbo.TblOHSPreventionRiskAssessRelations AS preriskre ON risktable.RiskAssessmentID = preriskre.RiskAssessmentID LEFT OUTER JOIN
                         dbo.TblOHSControlPrevention AS contpre ON preriskre.ControlPreventionID = contpre.ControlPreventionID


GO
/****** Object:  View [dbo].[V_PowerBI_InternalAuditUnsuitability]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PowerBI_InternalAuditUnsuitability] AS
SELECT
ap.AuditPlanID,
ard.questionID,
ap.AuditDate,
case 
	when ap.AuditOHS = 0 then 'ISGDEGIL'
	when ap.AuditOHS = 1 then 'ISG'
	else 'HATAISG' 
	end as 'ISGMI?',
s.SetName as SetName,
q.Section,
q.QDefination,
ard.explanation, 
CASE
    WHEN ard.ProcessPoint= ard.TechnicalPoint THEN 'Altyapı'
    WHEN ard.ProcessPoint= ard.InfrastructurePoint THEN 'Teknik'
    WHEN ard.TechnicalPoint= ard.InfrastructurePoint THEN 'Uygulama'
    ELSE '----'
END AS 'Status',
ld.SubLevelName,
case 
	when ard.IsRegulatoryActivity = 0 then 'MINOR'
	when ard.IsRegulatoryActivity = 1 then 'MAJOR'
	else 'HATAMAJOR' 
	end as 'SEVIYE?',

case 
	when ard.IsNonAudit = 0 then 'DENETIMICI'
	when ard.IsNonAudit = 1 then 'DENETIMDISI'
	else 'HATADD' 
	end as 'DENETIMDISI?',
at.TypeName,

vr.Name,
td1.TypeName Soru,
e.Name + ' ' + e.Surname as DENETCI

,ap.LocationID
,ap.DepartmentID
,l.LocationName
,d.DepartmentName

FROM [SARDUNYADBNEW].[dbo].TblAuditPlan as ap WITH (NOLOCK)

inner join [SARDUNYADBNEW].[dbo].TblAuditRealizeDetail as ard WITH (NOLOCK) on ard.AuditPlanID=ap.AuditPlanID
full join [SARDUNYADBNEW].[dbo].TblLevelDetail as ld WITH (NOLOCK) on ld.LevelDetailID=ard.LevelID 
inner join [SARDUNYADBNEW].[dbo].TblAuditType as at WITH (NOLOCK) on at.AuditTypeID=ap.AuditTypeID 
inner join [SARDUNYADBNEW].[dbo].TblQuestion as q WITH (NOLOCK) on q.QuestionID=ard.QuestionID
inner Join [SARDUNYADBNEW].[dbo].TblTypeDetail as td1 WITH (NOLOCK) on td1.TypeDetailId=q.QuestionTypeID
inner join [SARDUNYADBNEW].[dbo].TblAuditorAuditPlan as aap WITH (NOLOCK) on aap.AuditPlanID=ap.AuditPlanID
inner join [SARDUNYADBNEW].[dbo].TblAuditor as a WITH (NOLOCK) on a.AuditorID=aap.AuditorID
inner join [SARDUNYADBNEW].[dbo].TblEmployee as e WITH (NOLOCK) on e.EmployeeID=a.EmployeeID
inner join [SARDUNYADBNEW].[dbo].TblQuestionSet as s  WITH(NOLOCK) on ap.QuesSetTypeID=s.SetID
full join [SARDUNYADBNEW].[dbo].TblLocation as l WITH (NOLOCK) on l.LocationID=ap.LocationID
full join [SARDUNYADBNEW].[dbo].TblVirtualRegion as vr WITH (NOLOCK) on vr.VirtualRegionID=l.RegionID
full join [SARDUNYADBNEW].[dbo].TblDepartment as d WITH (NOLOCK) on d.DepartmentID=ap.DepartmentID
inner join [SARDUNYADBNEW].[dbo].TblAudit as [audit] WITH (NOLOCK) on ap.AuditID = [audit].AuditID
where
ard.Explanation is not null and [audit].AuditCode='InternalAudit'
GO
/****** Object:  View [dbo].[V_LocationPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[V_LocationPoint] AS
SELECT DISTINCT 
V.LocationID,
L.LocationName,
TD.TypeDetailId,
TD.TypeName,
V.YearID,
V.MonthID,
V.auditPoint,
V.CheckListPoint,
V.QualityPoint,
V.handPoint,
V.devicePoint,
V.majorPoint,
VR.VirtualRegionID,
VR.Name as "VirtualRegion"
from [SARDUNYADBNEW].[dbo].[V_AvveragePublishLocationPoints] AS V WITH (NOLOCK)
INNER JOIN [SARDUNYADBNEW].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID= V.LocationID
INNER JOIN [SARDUNYADBNEW].[dbo].TblVirtualRegion AS VR WITH (NOLOCK) ON L.RegionID=VR.VirtualRegionID
INNER JOIN [SARDUNYADBNEW].[dbo].TblTypeDetail AS TD WITH (NOLOCK)  ON L.LocationTypeID = TD.TypeDetailId
GO
/****** Object:  View [dbo].[V_Example]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_Example]
as 
select 
ap.AuditPlanID,ap.PlanName,ap.LocationID,ap.AuditDate,ap.IsAudited,ap.PlannerID,ap.QuesSetTypeID,ap.AuditID,ap.PeriodID,ap.ProductCatID,
ap.AuditorCount,ap.AuditOHS,ap.ConfirmDate,ap.ConfirmEmployeeID,
p.ProviderID,p.Name,p.IsActive,p.ProviderTypeID,p.WorkingFrequency,p.VirtualRegionID,p.Explanation,
aap.AuditorAuditPlanID,aap.AuditorID,aap.IsRealized,aap.IsConfirmAuth,aap.IsConfirmToken,aap.AuditorExplanation,aap.ManagerExplanation,
aap.AuditTrackingExplanation,aap.SignatureImage,aap.Statue,aap.AuditedExplanation,aap.AuditRealizedAuthName,aap.AuditRealizedAuthId,aap.IsCompleted
from TblAuditPlan ap inner join TblProvider p WITH (NOLOCK) on ap.ProviderID=p.ProviderID
inner join TblAuditorAuditPlan aap WITH (NOLOCK) on ap.AuditPlanID=aap.AuditPlanID
GO
/****** Object:  View [dbo].[V_BakanlikBildirim]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[V_BakanlikBildirim] as

SELECT

l.LocationName as 'Mutfak Adı',
c.Address as Adres,
vr.Name as Bölge

FROM [NetAuditDB].[dbo].TblLocation as l
inner join [NetAuditDB].[dbo].TblContact as c on c.ContactID=l.ContactID
inner join [NetAuditDB].[dbo].TblVirtualRegion as vr on vr.VirtualRegionID=l.RegionID

where 
l.IsActive=1 
and l.LocationName not like '%pilot%' 
and l.LocationName not like  '%merkez - Yemekh%' 
and l.LocationName not like  '%TUNA AY%' 
and l.LocationName not like  '%DENEME HKY%'
and l.LocationName not like '%kafe%' 
and l.LocationName not like '%TÜYAP SARDUNYA%' 
-- and vr.VirtualRegionID not in (12,13,8,11)
GO
/****** Object:  View [dbo].[V_PowerBI_AuditPointsPerProvider]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[V_PowerBI_AuditPointsPerProvider] as
SELECT distinct 

ap.AuditplanID,
p.Name as 'Tedarikçi Adı',
AP.auditdate as 'Tarih',
ar.TotalProcessPoint as 'Denetim Puanı',
e.Name + ' ' + e.Surname as 'Denetçi',
pc.CatName as 'Kategori Adı',
p.WorkingFrequency as 'Çalışma Sıklığı',
ard.Explanation as 'Uygunsuzluk'

FROM [NetAuditDB].[dbo].[TblAuditRealize] as ar WITH (NOLOCK)

inner join [NetAuditDB].[dbo].TblAuditPlan as ap WITH (NOLOCK) on ap.AuditPlanID=ar.AuditPlanID
inner join [NetAuditDB].[dbo].TblAuditRealizeDetail as ard WITH (NOLOCK) on ard.AuditPlanID=ap.AuditPlanID
inner join [NetAuditDB].[dbo].TblProvider as p WITH (NOLOCK) on p.ProviderID=ap.ProviderID
inner join [NetAuditDB].[dbo].TblAuditorAuditPlan AAP WITH (NOLOCK) ON AAP.AuditPlanID=AP.AuditPlanID
inner join [NetAuditDB].[dbo].TblAuditor A WITH (NOLOCK) ON A.AuditorID = AAP.AuditorID
inner join [NetAuditDB].[dbo].TblEmployee E WITH (NOLOCK) ON E.EmployeeID = A.EmployeeID
inner join [NetAuditDB].[dbo].TblProviderServices as ps WITH (NOLOCK) on ps.ProviderID=p.ProviderID
inner join [NetAuditDB].[dbo].TblProductCategory as pc WITH (NOLOCK) on pc.CatID=ps.CatId
GO
/****** Object:  View [dbo].[V_PowerBI_AuditPointsWithEffectivve]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 30.11.2018
Explanation : Denetim/Kontrol Puanları Efektif Puanlar Dahilinde
*/

CREATE VIEW [dbo].[V_PowerBI_AuditPointsWithEffectivve] AS

SELECT * FROM [NetAuditDB].[dbo].[V_PowerBIPublishLocationPoint]
GO
/****** Object:  View [dbo].[V_PowerBI_Hand&Device]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 16.11.2018
Explanation : El Araç 
*/

CREATE VIEW [dbo].[V_PowerBI_Hand&Device] AS
SELECT
AR.AuditPlanID, AP.AuditDate,AT.TypeName, 
E.Name + ' ' + E.Surname AS AuditorName,
AP.LocationID,L.LocationName,AP.ProviderID,P.Name AS ProviderName, TD.TypeName AS ProjectType, VR.Name AS VirtualRegion, 
E2.Name +' '+ E2.Surname AS ManagerName ,R.PositionName AS ManagerRole,AH.AuditedHandID,AH.PersonelName AS EmployeeName, AH.Ekoli, AH.Coliform, 
AH.StaphAeurus,AH.Statue AS HandStatus,AH.Explanation1,AH.Explanation2,
AD.AuditedDeviceID,D.DeviceName,
aa.AreaName AS DevicesArea,sp.ProcessName as DevicesProcess,
aa2.AreaName as EmployeeArea,sp2.ProcessName as EmployeeProcess,
D.DeviceID,AD.Result1,AD.Statue AS DeviceStatus
FROM [NetAuditDB].[dbo].TblAuditRealize AS AR WITH (NOLOCK)
INNER JOIN[NetAuditDB].[dbo].TblAuditPlan AS AP WITH (NOLOCK) ON AR.AuditPlanID = AP.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditType AS AT WITH (NOLOCK) ON AT.AuditTypeID = AP.AuditTypeID 
LEFT JOIN [NetAuditDB].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID = AP.LocationID 
LEFT JOIN [NetAuditDB].[dbo].TblProvider AS P WITH (NOLOCK) ON P.ProviderID = AP.ProviderID 
LEFT JOIN [NetAuditDB].[dbo].TblVirtualRegion AS VR WITH (NOLOCK) ON L.RegionID = VR.VirtualRegionID 
LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail AS TD WITH (NOLOCK) ON L.LocationTypeID = TD.TypeDetailId 
LEFT JOIN [NetAuditDB].[dbo].TblAuditorAuditPlan AS AAP WITH (NOLOCK) ON AP.AuditPlanID = AAP.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditor AS A WITH (NOLOCK) ON AAP.AuditorID = A.AuditorID
LEFT JOIN [NetAuditDB].[dbo].TblEmployee AS E WITH (NOLOCK) ON A.EmployeeID = E.EmployeeID 
LEFT JOIN [NetAuditDB].[dbo].TblEmployeeLocation AS EL WITH (NOLOCK) ON EL.LocationID = L.LocationID
LEFT JOIN [NetAuditDB].[dbo].TblEmployee AS E2 WITH (NOLOCK) ON E2.EmployeeID = EL.EmployeeID
LEFT JOIN [NetAuditDB].[dbo].TblRoles R WITH (NOLOCK) ON R.RoleID = E2.PositionRoleID
LEFT JOIN [NetAuditDB].[dbo].TblAuditedHands AS AH WITH (NOLOCK) on AR.AuditPlanID=AH.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblAuditedDevice AS AD WITH (NOLOCK) on AR.AuditPlanID=AD.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblDevices AS D WITH (NOLOCK) on AD.DeviceID=D.DeviceID
LEFT JOIN [NetAuditDB].[dbo].TblAuditArea as AA WITH (NOLOCK) on AA.AuditScopeID=AD.AreaID
LEFT JOIN [NetAuditDB].[dbo].TblServiceProcess as SP WITH (NOLOCK) on SP.ProcessID=AD.ProcessID
LEFT JOIN [NetAuditDB].[dbo].TblAuditArea as AA2 WITH (NOLOCK) on AA2.AuditScopeID=AH.AreaID
LEFT JOIN [NetAuditDB].[dbo].TblServiceProcess as SP2 WITH (NOLOCK) on SP2.ProcessID=AH.ProcessID
--WHERE AP.IsAudited = 1 //sure ?
GO
/****** Object:  View [dbo].[V_PowerBI_IndividualAuditResult]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
0 First Release Date : 09.09.2019
0 Explanation : İSG ve merkezlerin bireysel denetimlerinin puanlarını görüntülemek için oluşturulmuştur. 
*/

CREATE view [dbo].[V_PowerBI_IndividualAuditResult] as
select 
r.AuditPlanID,
p.AuditDate,
empp.Name+' '+empp.Surname as Denetci,
p.AuditTypeID,
t.TypeName,
t.AffectPerformance,
p.LocationID,
l.LocationName,
typd.TypeName as lokasyontürü,
l.LocationTypeID,
l.RegionID ,
v.Name,
r.TotalPoint, 
r.TotalProcessPoint,
r.MajorPoint,
r.HandSamplePoint,
r.ItemSamplePoint, 
r.ProcesTecnicPoint, 
r.ProcesInfraPoint,
r.InfraMajorPoint,
r.TechMajorPoint,
p.AuditOHS,
r.[QualityPoint] as KalitePuan,
poz.PersonelAdi,
poz.Pozisyonu
from [NetAuditDB].[dbo].TblAuditRealize as r WITH (NOLOCK)
inner join  [NetAuditDB].[dbo].TblAuditPlan as p WITH (NOLOCK) on r.AuditPlanID=p.AuditPlanID
left outer join [NetAuditDB].[dbo].TblAuditType as t WITH (NOLOCK) on t.AuditTypeID = p.AuditTypeID 
left outer join [NetAuditDB].[dbo].TblLocation as l WITH (NOLOCK) on l.LocationID= p.LocationID
left outer join [NetAuditDB].[dbo].TblVirtualRegion as v WITH (NOLOCK) on l.RegionID=v.VirtualRegionID
left outer join [NetAuditDB].[dbo].TblTypeDetail as typd WITH (NOLOCK) on l.LocationTypeID = typd.TypeDetailId
left outer join [NetAuditDB].[dbo].TblAuditorAuditPlan as au WITH (NOLOCK) on p.AuditPlanID =au.AuditPlanID
left outer join [NetAuditDB].[dbo].TblAuditor as a WITH (NOLOCK) on au.AuditorID =a.AuditorID
left outer join [NetAuditDB].[dbo].TblEmployee as empp WITH (NOLOCK) on a.EmployeeID =empp.EmployeeID
left outer join [NetAuditDB].[dbo].[V_GetResponsibleLocationInfo] as poz WITH (NOLOCK) on p.LocationID=poz.LocationID
GO
/****** Object:  View [dbo].[V_PowerBI_Minutes]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 25.10.2018
Explanation : Tutanaklar
*/

CREATE VIEW [dbo].[V_PowerBI_Minutes] AS
SELECT 
MD.MinutesDetailID AS Id,
CASE WHEN MD.ServicesMinutesID IS NULL THEN 1 ELSE 0 END AS IsAudit, /* 1:Denetim;0:Mutfak*/
CASE WHEN MD.ServicesMinutesID IS  NULL THEN AR.AuditDate ELSE SM.Date END AS DeterminationDate, /* Denetim / Mutfak */
L.LocationId,L.LocationName AS Location,
VirtualRegion = (SELECT Name FROM [NetAuditDB].[dbo].TblVirtualRegion WHERE VirtualRegionID=L.RegionID),
E.Name+' '+E.Surname AS EmployeeName,
R.RoleName AS EmployeeRole,
PC.CatName AS ProductCategory,
MD.ProductName,
MD.Quantity Quantity,
UT.UnitName AS QuantityType,
P.ProcessName AS Process,
US.UnsuitabilitySourceName AS UnsuitabilitySource,
D.DistortedName AS Distorted,
MD.ProductionDate,
MD.WarehouseEntryDate,
MD.ExpirationDate
FROM [NetAuditDB].[dbo].TblMinutesDetail MD WITH (NOLOCK)
LEFT JOIN [NetAuditDB].[dbo].TblAuditPlan AP WITH (NOLOCK) ON AP.AuditPlanID = MD.AuditPlanID
LEFT JOIN [NetAuditDB].[dbo].TblServicesMinutes SM WITH (NOLOCK) ON SM.ServicesMinutesID = MD.ServicesMinutesID
LEFT JOIN [NetAuditDB].[dbo].TblAuditRealize AR WITH (NOLOCK) ON AR.AuditPlanID = AP.AuditPlanID 
LEFT JOIN [NetAuditDB].[dbo].TblLocation L WITH (NOLOCK) ON L.LocationID = AP.LocationID OR L.LocationID=SM.LocationID /* Denetim / Mutfak */
LEFT JOIN [NetAuditDB].[dbo].TblAuditor A WITH (NOLOCK) ON A.AuditorID = MD.AuditorID
LEFT JOIN [NetAuditDB].[dbo].TblEmployee E WITH (NOLOCK) ON E.EmployeeID = A.EmployeeID  OR E.EmployeeID=SM.EmployeeID /* Denetim / Mutfak */
LEFT JOIN [NetAuditDB].[dbo].TblRoles R WITH (NOLOCK) ON R.RoleID = E.PositionRoleID
INNER JOIN [NetAuditDB].[dbo].TblProductCategory PC WITH (NOLOCK) ON PC.CatID = MD.ProductTypeID
INNER JOIN [NetAuditDB].[dbo].TblUnitType UT WITH (NOLOCK) ON UT.UnitID = MD.UnitID
INNER JOIN [NetAuditDB].[dbo].TblProcess P WITH (NOLOCK) ON P.ProcessID = MD.ProcessID
INNER JOIN [NetAuditDB].[dbo].TblUnsuitabilitySource US WITH (NOLOCK) ON US.UnsuitabilitySourceID = MD.UnsuitabilitySourceID
LEFT JOIN [NetAuditDB].[dbo].TblDistorted D WITH (NOLOCK) ON D.DistortedID = MD.DistortedID

where AR.AuditDate >= '2018-06-01' or SM.Date >= '2018-06-01'
GO
/****** Object:  View [dbo].[V_PowerBI_MonitoringAndMeasurement]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
Date : 18.09.2019/24.09.2019
Explanation : İSG BİRİMİ TARAFINDAN KULLANILACAK İZLEME ÖLÇME ÇİZELGE POWERBI İÇİN OLUŞTURULMUŞTUR. EKİPMAN FAALİYET AYRILMIŞTIR. 
*/


CREATE VIEW [dbo].[V_PowerBI_MonitoringAndMeasurement] AS SELECT 

 mam.[MonitoringAndMeasurementID]
,mr.MonitoringResponsibleID
,mer.MeasurementResponsibleID
,mamp.MonitoringAndMeasurementPeriodID
,mam.[LocationID]
,ea.Equipment_Activity as 'Ekipman/Süreç Adı'

,case
	when ea.IsEquipment=1 then 'Ekipman'
	when ea.IsEquipment=0 then 'Faaliyet'
	else 'Error Ekipman/Süreç' end as 'Ekipman mı, Faaliyet mi?' 

,mam.[DocumentName] as "Belge Adı"
,mam.[Foundation] as "Belge Kuruluşu"
,mam.[TakeDate] as "Belge Tarihi"
,mam.[ValidityDate] as "Geçerlilik Tarihi"
,mam.[QuantityControl] "Kalite Gerekliliği"
,mam.[LegalControl] as "Yasal Zorunluluk"
,mam.[IsActive] as "Plan Aktif mi?"
,mamp.Date as "Kontrol Tarihi"

,CASE 
	WHEN MAMP.Control=0 then 'Kontrol Yapılmadı'
	when mamp.Control=1 then 'Kontrol Yapıldı'
	else 'ERROR CONTROL' END AS 'Kontrol Durumu'
,case
	when mam.ISG_CYS=1 then 'İSG'
	when mam.ISG_CYS=0 then 'ÇYS'
	else 'ERROR İSG/ÇYS' END AS "İSG/ÇYS"

--,mr.EmployeeID as "İzleme Sorumlusu"
--,mer.EmployeeID as "Ölçme Sorumlusu"

,emr.Name + ' ' + emr.Surname as "İzleme Sorumlusu"
,emer.Name + ' ' + emer.Surname as "Ölçme Sorumlusu"

FROM [NetAuditDB].[dbo].[TblOHSMonitoringAndMeasurement] as mam WITH (NOLOCK)

left join [NetAuditDB].[dbo].[TblOHSMonitoringResponsible] as mr WITH (NOLOCK) on mr.MonitoringAndMeasurementID=mam.MonitoringAndMeasurementID
left join [NetAuditDB].[dbo].[TblOHSMeasurementResponsible] as mer WITH (NOLOCK) on mer.MonitoringAndMeasurementID=mam.MonitoringAndMeasurementID
left join [NetAuditDB].[dbo].[TblMonitoringAndMeasurementPeriod] as mamp WITH (NOLOCK) on mamp.MonitoringAndMeasurementID=mam.MonitoringAndMeasurementID
left join [NetAuditDB].[dbo].[TblOHSEquipment_Activity] as ea WITH (NOLOCK) on ea.IncKeyNo=mam.IncKeyNo
left join [NetAuditDB].[dbo].TblEmployee as emr WITH (NOLOCK) on emr.EmployeeID=mr.EmployeeID
left join [NetAuditDB].[dbo].TblEmployee as emer WITH (NOLOCK) on emer.EmployeeID=mer.EmployeeID
GO
/****** Object:  View [dbo].[V_PowerBI_PublishLocationPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



















/* 
Author : ERHAN ÇINAR
Date : 21.11.2021
Explanation : AYLIK HİJYEN DENETİM PUANI
*/



CREATE VIEW [dbo].[V_PowerBI_PublishLocationPoint] AS

select
*
from openquery(local,'exec NetAuditDB.dbo.SP_PublishLocationPoint')

GO
/****** Object:  View [dbo].[V_PowerBI_RamakWorkAccident]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 18.10.2018
Explanation : Ramak Kala İş Kazaları, isactive ve personel eklendi
*/


CREATE VIEW [dbo].[V_PowerBI_RamakWorkAccident] AS 
SELECT 
WAR.WorkAccidentSmallID AS Id,
WAR.Date AS Date,
WAR.[IsActive],
war.[Employee],
DATEPART(W,WAR.DATE) AS DayOfWeek,
L.LocationName AS ProjectName,
VR.Name AS VirtualRegion,
D.DepartmentName AS Departmens,
ORWARC.Explanation AS RootCause,
AccidentType = T.TypeName
FROM [NetAuditDB].[dbo].TblOHSWorkAccidentRemak WAR WITH (NOLOCK)
LEFT JOIN [NetAuditDB].[dbo].TblLocation L WITH (NOLOCK) ON L.LocationID=WAR.LocationID
LEFT JOIN [NetAuditDB].[dbo].TblVirtualRegion VR WITH (NOLOCK) ON VR.VirtualRegionID = L.RegionID
LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail T WITH (NOLOCK) ON T.TypeDetailId = WAR.AccidentTypeID
LEFT JOIN [NetAuditDB].[dbo].TblDepartment D WITH (NOLOCK) ON D.DepartmentID = WAR.DepartmentID 
LEFT JOIN [NetAuditDB].[dbo].TblOHSRemakWorkAccRootCause ORWARC WITH (NOLOCK) ON ORWARC.RootCauseID = WAR.RootCauseID 
WHERE WAR.WorkAccAndRemakID = 406
GO
/****** Object:  View [dbo].[V_PowerBI_RiskAssessmentAdditional]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
Date : 17.09.2019
Explanation : [V_PowerBI_RiskAssessment] ile beraber powerbi içerisinde join yapısıyla birlikte kullanılacaktır.
*/


CREATE VIEW [dbo].[V_PowerBI_RiskAssessmentAdditional] AS 


select orat.RiskAssessmentID,
STRING_AGG(ocp.ControlPreventionExplanation,',' ) within group (order by orat.RiskAssessmentID) as "Ek Tedbirler"
from [NetAuditDB].[dbo].TblOHSAdditionalPreventionRiskAssessRelations oaprr WITH (NOLOCK)
left join [NetAuditDB].[dbo].TblOHSRiskAssessmentTable orat WITH (NOLOCK) on oaprr.RiskAssessmentID=orat.RiskAssessmentID 
left join [NetAuditDB].[dbo].TblOHSControlPrevention ocp WITH (NOLOCK) on oaprr.ControlPreventionID=ocp.ControlPreventionID
group by orat.RiskAssessmentID
GO
/****** Object:  View [dbo].[V_PowerBI_RiskAssessmentPrevention]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
Date : 17.09.2019
Explanation : [V_PowerBI_RiskAssessment] ile beraber powerbi içerisinde join yapısıyla birlikte kullanılacaktır.
*/


CREATE VIEW [dbo].[V_PowerBI_RiskAssessmentPrevention] AS 


select orat.RiskAssessmentID,
STRING_AGG(ocp.ControlPreventionExplanation,',' ) within group (order by orat.RiskAssessmentID) as "Mevcut Tedbirler"
from [NetAuditDB].[dbo].TblOHSPreventionRiskAssessRelations oaprr WITH (NOLOCK)
left join [NetAuditDB].[dbo].TblOHSRiskAssessmentTable orat WITH (NOLOCK) on oaprr.RiskAssessmentID=orat.RiskAssessmentID
left join [NetAuditDB].[dbo].TblOHSControlPrevention ocp WITH (NOLOCK) on oaprr.ControlPreventionID=ocp.ControlPreventionID
group by orat.RiskAssessmentID
GO
/****** Object:  View [dbo].[V_PowerBI_SmallWorkAccident]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
Author : OSMAN ŞAKİR 'OMANSAK' KAPAR 
Date : 18.10.2018
Explanation : Küçük İş Kazaları, isactive ve personel eklendi
*/

CREATE VIEW [dbo].[V_PowerBI_SmallWorkAccident] AS 
SELECT 
WAR.WorkAccidentSmallID AS Id,
WAR.Date AS Date,
WAR.[IsActive], 
war.[Employee],
DATEPART(W,WAR.DATE) AS DayOfWeek,
L.LocationName AS ProjectName,
VR.Name AS VirtualRegion,
D.DepartmentName AS Departmens,
ORWARC.Explanation AS RootCause,
AccidentType = T.TypeName
FROM [NetAuditDB].[dbo].TblOHSWorkAccidentRemak WAR WITH (NOLOCK)
LEFT JOIN [NetAuditDB].[dbo].TblLocation L WITH (NOLOCK) ON L.LocationID=WAR.LocationID
LEFT JOIN [NetAuditDB].[dbo].TblVirtualRegion VR WITH (NOLOCK) ON VR.VirtualRegionID = L.RegionID
LEFT JOIN [NetAuditDB].[dbo].TblTypeDetail T WITH (NOLOCK) ON T.TypeDetailId = WAR.AccidentTypeID
LEFT JOIN [NetAuditDB].[dbo].TblDepartment D WITH (NOLOCK) ON D.DepartmentID = WAR.DepartmentID 
LEFT JOIN [NetAuditDB].[dbo].TblOHSRemakWorkAccRootCause ORWARC WITH (NOLOCK) ON ORWARC.RootCauseID = WAR.RootCauseID 
WHERE WAR.WorkAccAndRemakID = 405
GO
/****** Object:  View [dbo].[V_PowerBIEmployee]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Author : UĞUR 'baydioglu' BAYDIOĞLU 
0 First Release Date : 27.08.2019
0 Explanation : Şikayetler için oluşturulmuş Viewdir. 252 ip'den veri çekmelidir. PowerBI tarafından veriler görüntülenebilir.
*/



Create VIEW [dbo].[V_PowerBIEmployee] AS
SELECT 
*

FROM [NetAuditDB].[dbo].TblEmployee 
GO
/****** Object:  Table [dbo].[AuditEntries]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditEntries](
	[AuditEntryID] [int] IDENTITY(1,1) NOT NULL,
	[EntitySetName] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[EntityPrimaryKey] [int] NULL,
	[State] [int] NOT NULL,
	[StateName] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[CreatedByID] [int] NULL,
	[CreatedBy] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ComputerIP] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_dbo.AuditEntries] PRIMARY KEY CLUSTERED 
(
	[AuditEntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditEntryProperties]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditEntryProperties](
	[AuditEntryPropertyID] [int] IDENTITY(1,1) NOT NULL,
	[AuditEntryID] [int] NOT NULL,
	[PropertyName] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[OldValue] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[NewValue] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_dbo.AuditEntryProperties] PRIMARY KEY CLUSTERED 
(
	[AuditEntryPropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeciciTablo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeciciTablo](
	[SoruPuani] [float] NULL,
	[Yetersiz] [float] NULL,
	[UygunDeil] [float] NULL,
	[Soru] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[Kategorisi] [int] NULL,
	[KatAdi] [nvarchar](250) COLLATE Turkish_CI_AS NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lab]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lab](
	[TedarikName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[CatID] [int] NULL,
	[MaterialName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[ProviderID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionTemp]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionTemp](
	[id] [int] NOT NULL,
	[QPoint] [float] NULL,
	[QLowPoint] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAccrdtAssn]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAccrdtAssn](
	[AssnID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderServiceID] [int] NULL,
	[LocationID] [int] NULL,
	[AccID] [int] NULL,
	[DocumentID] [int] NULL,
	[ProviderID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AssnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAccreditation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAccreditation](
	[AccID] [int] IDENTITY(1,1) NOT NULL,
	[AccreditionName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsObligatory] [bit] NULL,
	[AccSetID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__TblAccre__91CBC398E5B822EC] PRIMARY KEY CLUSTERED 
(
	[AccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAccSet]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAccSet](
	[AccSetID] [int] IDENTITY(1,1) NOT NULL,
	[SetName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[DocumentID] [int] NULL,
	[RegulationID] [int] NULL,
	[Explanation] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblAccSet] PRIMARY KEY CLUSTERED 
(
	[AccSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppPrivilege]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppPrivilege](
	[AppPrivilegeID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Description] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[PrivilegeTypeID] [int] NULL,
	[ItemID] [int] NULL,
 CONSTRAINT [PK_TblAppPrivilege_1] PRIMARY KEY CLUSTERED 
(
	[AppPrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppRolePrivilege]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppRolePrivilege](
	[AppRolePrivilegeID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[AppPrivilegeID] [int] NULL,
	[PrivRead] [bit] NOT NULL,
	[PrivUpdate] [bit] NOT NULL,
	[PrivDelete] [bit] NOT NULL,
	[PrivInsert] [bit] NOT NULL,
	[PrivFull] [bit] NOT NULL,
 CONSTRAINT [PK_TblAppPrivilege] PRIMARY KEY CLUSTERED 
(
	[AppRolePrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppSetting]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppSetting](
	[SettingID] [int] IDENTITY(1,1) NOT NULL,
	[SettingCategory] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[SettingName] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[SettingCode] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[SettingValue] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblAppSetting] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAppSubMenuItem_Y]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAppSubMenuItem_Y](
	[SubMenuItemID] [int] IDENTITY(1,1) NOT NULL,
	[LinkText] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[ControllerName] [nvarchar](75) COLLATE Turkish_CI_AS NOT NULL,
	[ActionName] [nvarchar](75) COLLATE Turkish_CI_AS NOT NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ShowMenuItem] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TabMenuItemID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAttend]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAttend](
	[AttendedID] [int] IDENTITY(1,1) NOT NULL,
	[TargetAttendID] [int] NULL,
	[EmployeeID] [int] NULL,
	[LocationID] [int] NULL,
	[DepartmanID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AttendedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAttendProviderServiceLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAttendProviderServiceLocation](
	[LocProvID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[ProviderServiceID] [int] NULL,
	[Explanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblAttendProviderServiceLocation] PRIMARY KEY CLUSTERED 
(
	[LocProvID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditArea]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditArea](
	[AuditScopeID] [int] IDENTITY(1,1) NOT NULL,
	[AreaName] [nvarchar](300) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblAuditArea] PRIMARY KEY CLUSTERED 
(
	[AuditScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditAreaPlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditAreaPlan](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[AuditScopeID] [int] NULL,
 CONSTRAINT [PK_TblAuditAreaPlan] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditAveragePoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditAveragePoint](
	[AverageID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[ProviderID] [int] NULL,
	[AveragePoint] [float] NULL,
 CONSTRAINT [PK_TblAuditAveragePoint] PRIMARY KEY CLUSTERED 
(
	[AverageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditMeasurePlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditMeasurePlan](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[MeasurementID] [int] NOT NULL,
	[AuditPlanID] [int] NOT NULL,
 CONSTRAINT [PK_TblAuditMeasurePlan] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditorEffort]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditorEffort](
	[EffortID] [int] IDENTITY(1,1) NOT NULL,
	[AuditorID] [int] NULL,
	[Effort] [float] NULL,
	[EffortDate] [date] NULL,
 CONSTRAINT [PK_TblAuditorEffort] PRIMARY KEY CLUSTERED 
(
	[EffortID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditPlanLog]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditPlanLog](
	[AuditPlanLogID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[AuditID] [int] NULL,
	[AuditTypeID] [int] NULL,
	[LocationID] [int] NULL,
	[ProviderID] [int] NULL,
	[AuditDate] [datetime] NULL,
	[QuesSetTypeID] [int] NULL,
	[PeriodID] [int] NULL,
	[ProductCatID] [int] NULL,
	[AuditOHS] [bit] NULL,
	[IsAudited] [bit] NULL,
	[IsApproved] [bit] NULL,
	[IsActive] [bit] NULL,
	[PlannerID] [int] NULL,
	[DeleteEmployeeID] [int] NULL,
	[DeleteComputerIP] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[DeleteDate] [datetime] NULL,
	[TotalPoint] [float] NULL,
	[TotalProcessPoint] [float] NULL,
	[HandSamplePoint] [float] NULL,
	[DeviceSamplePoint] [float] NULL,
	[MajorPoint] [float] NULL,
	[QualityPoint] [float] NULL,
 CONSTRAINT [PK_TblAuditPlanLog] PRIMARY KEY CLUSTERED 
(
	[AuditPlanLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditPointInfo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditPointInfo](
	[AuditPointId] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[TypeDetailId] [int] NULL,
	[TypeName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[ManagerName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[RoleName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[YearID] [int] NULL,
	[MonthID] [int] NULL,
	[auditPoint] [float] NULL,
	[CheckListPoint] [float] NULL,
	[QualityPoint] [float] NULL,
	[handPoint] [float] NULL,
	[devicePoint] [float] NULL,
	[majorPoint] [float] NULL,
	[VirtualRegionID] [int] NULL,
	[VirtualRegion] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_TblAuditPointInfo] PRIMARY KEY CLUSTERED 
(
	[AuditPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditProviderRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditProviderRelations](
	[RelationID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCatID] [int] NULL,
	[AuditTypeID] [int] NULL,
	[ExpertID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblAuditProviderRelations] PRIMARY KEY CLUSTERED 
(
	[RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditQuesCatPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditQuesCatPoint](
	[inckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[QuesCatID] [int] NULL,
	[ProcessPoint] [float] NULL,
	[TecnicPoint] [float] NULL,
	[InfraPoint] [float] NULL,
	[ProcessTecnicPoint] [float] NULL,
	[ProcessInfPoint] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[inckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditQuestionCatGroup]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditQuestionCatGroup](
	[AuditQuestionCatGroupID] [int] IDENTITY(1,1) NOT NULL,
	[AuditEvidenceQuestionGroupName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblAuditQuestionCatGroup] PRIMARY KEY CLUSTERED 
(
	[AuditQuestionCatGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditRealizeHistory]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditRealizeHistory](
	[AuditRealizeHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[LocationTypeID] [int] NULL,
	[VirtualRegionID] [int] NULL,
	[IKUPositionID] [int] NULL,
	[IKUEmployeeID] [int] NULL,
	[OD_ODYPositionID] [int] NULL,
	[OD_ODYEmployeeID] [int] NULL,
	[BMPositonID] [int] NULL,
	[BMEmployeeID] [int] NULL,
	[BMYPositionID] [int] NULL,
	[BMYEmployeeID] [int] NULL,
	[AuditorPositionID] [int] NULL,
	[AuditorID] [int] NULL,
	[AuditPuan] [float] NULL,
	[ISG_KYS_CYS_Puan] [float] NULL,
	[HygienePuan] [float] NULL,
	[MajorErrorPuan] [float] NULL,
	[HygienePuanD] [float] NULL,
	[HandCulturePuan] [float] NULL,
	[DeviceCulturePuan] [float] NULL,
	[CheckListPuan] [float] NULL,
	[AuditDate] [date] NULL,
 CONSTRAINT [PK_TblAuditRealizeHistory] PRIMARY KEY CLUSTERED 
(
	[AuditRealizeHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditRealizeImage]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditRealizeImage](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[ImageName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[ImagePath] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[AuditReDetID] [int] NULL,
 CONSTRAINT [PK_TblAuditRealizeImage] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditRealizeMeasureResult]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditRealizeMeasureResult](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[MeasureID] [int] NULL,
	[MeasValue] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Result] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[NonAudit] [bit] NULL,
	[AuditPlanID] [int] NULL,
	[AuditorID] [int] NULL,
	[ButtonStatue] [bit] NULL,
 CONSTRAINT [PK_TblAuditRealizeMeasureResult] PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditRealizeResponsible]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditRealizeResponsible](
	[AuditReResponsibleID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[EmployeeID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_TblAuditRealizeResponsible] PRIMARY KEY CLUSTERED 
(
	[AuditReResponsibleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblAuditTypeRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblAuditTypeRelationship](
	[TypeAuditRealID] [int] IDENTITY(1,1) NOT NULL,
	[AuditID] [int] NULL,
	[AuditTypeID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblAuditTypeRelationship] PRIMARY KEY CLUSTERED 
(
	[TypeAuditRealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCalibrationDevice]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCalibrationDevice](
	[CalibrationDeviceID] [int] IDENTITY(1,1) NOT NULL,
	[DeviceName] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CalibrationDeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCalibrationDeviceDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCalibrationDeviceDetail](
	[CalibrationDeviceDetailID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[DepartmentID] [int] NULL,
	[DeviceID] [int] NOT NULL,
	[RequestEmployeeID] [int] NULL,
	[Manufacturer] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[DeviceCode] [nvarchar](20) COLLATE Turkish_CI_AS NULL,
	[ReceiverEmployeeID] [int] NOT NULL,
	[DeliverDate] [smalldatetime] NULL,
	[MeasuringRangeOfDevice] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[CalibrationPeriodID] [int] NULL,
	[AcceptanceToleranceID] [int] NULL,
	[OperatingRange] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[CalibrationProviderID] [int] NULL,
	[CalibrationCertificateNumber] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[CalibrationDate] [smalldatetime] NULL,
	[CalibrationDate2] [smalldatetime] NULL,
	[CalibrationDate3] [smalldatetime] NULL,
	[DeviationValue] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[MeasuringRange] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[EligibilityStatusID] [int] NULL,
	[IsForUpdate] [bit] NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedEmployeeID] [int] NOT NULL,
	[UpdatedDate] [smalldatetime] NULL,
	[UpdatedEmployeeID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__TblCalib__CC38FA42D84BC231] PRIMARY KEY CLUSTERED 
(
	[CalibrationDeviceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCalibrationDevicePlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCalibrationDevicePlan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CalibrationDeviceDetailId] [int] NOT NULL,
	[PlanedEmoloyeId] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedEmployeeID] [int] NOT NULL,
	[UpdatedDate] [smalldatetime] NOT NULL,
	[UpdatedEmployeeID] [int] NOT NULL,
	[IsActive] [int] NOT NULL,
 CONSTRAINT [PK_TblCalibrationDevicePlan] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCalibrationDocument]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCalibrationDocument](
	[CalibrationDocID] [int] IDENTITY(1,1) NOT NULL,
	[CalDeviceDetailID] [int] NOT NULL,
	[CalDeviceID] [int] NOT NULL,
	[Name] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[Path] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[DocumentType] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblCalibrationDocument] PRIMARY KEY CLUSTERED 
(
	[CalibrationDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCalibrationInvoiceDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCalibrationInvoiceDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VirtualRegionId] [int] NULL,
	[RelatedGroup] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[InvoiceAdress] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblCalibrationInvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCustomerOTL]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCustomerOTL](
	[CustomerOTLID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[ApprovedProviderPublishDate] [smalldatetime] NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedEmployee] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblCustomerOTL] PRIMARY KEY CLUSTERED 
(
	[CustomerOTLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCustomerOTLDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCustomerOTLDetail](
	[CustomerOTLDetailID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerOTLID] [int] NULL,
	[ProviderID] [int] NOT NULL,
	[CategoryID] [int] NULL,
	[Explanation] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblCustomerOTLDetail] PRIMARY KEY CLUSTERED 
(
	[CustomerOTLDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDBParameters]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDBParameters](
	[ParameterID] [int] IDENTITY(1,1) NOT NULL,
	[ParameterTypeID] [int] NOT NULL,
	[ParameterName] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Param] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__TblProvi__F80C62978F6D2CDB] PRIMARY KEY CLUSTERED 
(
	[ParameterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDBParameterTypes]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDBParameterTypes](
	[ParameterTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ParameterTypeName] [nvarchar](150) COLLATE Turkish_CI_AS NOT NULL,
	[ParentType] [nvarchar](150) COLLATE Turkish_CI_AS NOT NULL,
 CONSTRAINT [PK__TblProvi__7FF7AC58E99B2F0C] PRIMARY KEY CLUSTERED 
(
	[ParameterTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDepartmentRoleRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDepartmentRoleRelationship](
	[DepartmentRoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK_TblDepartmentRoleRelationship] PRIMARY KEY CLUSTERED 
(
	[DepartmentRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDistorted]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDistorted](
	[DistortedID] [int] IDENTITY(1,1) NOT NULL,
	[DistortedName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblDistorted] PRIMARY KEY CLUSTERED 
(
	[DistortedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDocumentAuthority]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDocumentAuthority](
	[DocumentAuthorityID] [int] IDENTITY(1,1) NOT NULL,
	[ProcedureDocumentID] [int] NULL,
	[RoleID] [int] NULL,
	[LocationTypeID] [int] NULL,
	[ShowStatue] [bit] NULL,
	[DownloadStatue] [bit] NULL,
 CONSTRAINT [PK_TblDocumentAuthority] PRIMARY KEY CLUSTERED 
(
	[DocumentAuthorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblDosya]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDosya](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DosyaTur] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[ParentId] [int] NOT NULL,
	[Baslik] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[DosyaAdi] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[DosyaYolu] [nvarchar](350) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_TblDosya] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmergency]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmergency](
	[EmergencyId] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NULL,
	[EventDate] [datetime] NULL,
	[EventExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[EventEffect] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Damage] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Reason] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Opinion] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Result] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[State] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[TypeId] [int] NULL,
	[DeviceId] [int] NULL,
	[CreatedUserId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedUserId] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ClosedUserId] [int] NULL,
	[IsClosed] [bit] NULL,
	[ClosedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[DepartmentId] [int] NULL,
 CONSTRAINT [PK_TblEmergency] PRIMARY KEY CLUSTERED 
(
	[EmergencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmergencyAction]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmergencyAction](
	[ActionId] [int] IDENTITY(1,1) NOT NULL,
	[EmergencyId] [int] NULL,
	[DepartmentId] [int] NULL,
	[ActionDate] [datetime] NULL,
	[ActionExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblEmergencyAction] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmergencyDocument]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmergencyDocument](
	[EmergencyDocId] [int] IDENTITY(1,1) NOT NULL,
	[EmergencyId] [int] NULL,
	[Name] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Path] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblEmergencyDocument] PRIMARY KEY CLUSTERED 
(
	[EmergencyDocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmergencyRootCause]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmergencyRootCause](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmergencyRootCauseName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[TypeDetailId] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblEmergencyRootCause] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmployeeCertificate]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployeeCertificate](
	[EmpCertificateID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[CertificateID] [int] NULL,
	[DocumentID] [int] NULL,
 CONSTRAINT [PK_TblEmployeeCertificate] PRIMARY KEY CLUSTERED 
(
	[EmpCertificateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmployeeMeasDevice]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployeeMeasDevice](
	[EmpMeasDeviceID] [int] IDENTITY(1,1) NOT NULL,
	[MeasDeviceID] [int] NULL,
	[EmployeeID] [int] NULL,
	[FixedAssetNumber] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblEmployeeMeasDevice] PRIMARY KEY CLUSTERED 
(
	[EmpMeasDeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmployeeProvider]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployeeProvider](
	[EmpProviderID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ProviderID] [int] NOT NULL,
	[AuthType] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Password] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PasswordToken] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblEmployeeProvider] PRIMARY KEY CLUSTERED 
(
	[EmpProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmployeeRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployeeRelationship](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentEmployeeID] [int] NOT NULL,
	[ChildEmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_TblEmployeeRelationship] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmployeeRoles]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployeeRoles](
	[EmpRoleID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_TblEmployeeRoles] PRIMARY KEY CLUSTERED 
(
	[EmpRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEvidenceFromAudit]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEvidenceFromAudit](
	[EvidenceAuditID] [int] NOT NULL,
	[AudReDetID] [int] NULL,
	[EvidenceID] [int] NULL,
 CONSTRAINT [PK_TblEvidenceFromAudit] PRIMARY KEY CLUSTERED 
(
	[EvidenceAuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFixedActivity]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFixedActivity](
	[FixedActivityID] [int] IDENTITY(1,1) NOT NULL,
	[PlanDate] [datetime] NULL,
	[RealizeDate] [datetime] NULL,
	[ConfirmDate] [datetime] NULL,
	[AuditReDetID] [int] NULL,
	[EvidenceNumber] [int] NULL,
	[RetCount] [int] NULL,
	[PlanEmployeeID] [int] NULL,
	[RealizeEmployeeID] [int] NULL,
 CONSTRAINT [PK_TblFixedActivity] PRIMARY KEY CLUSTERED 
(
	[FixedActivityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormAuthority]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormAuthority](
	[FormAuthorityID] [int] IDENTITY(1,1) NOT NULL,
	[FormUpdate] [bit] NULL,
	[FormShow] [bit] NULL,
	[FormDelete] [bit] NULL,
	[FormFill] [bit] NULL,
	[FormExport] [bit] NULL,
	[FormShowList] [bit] NULL,
	[FormID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_TblFormAuthority] PRIMARY KEY CLUSTERED 
(
	[FormAuthorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormAuthorityRole]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormAuthorityRole](
	[FormAuthrityRoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[FormAuthorityID] [int] NULL,
 CONSTRAINT [PK_TblFormAuthorityRole] PRIMARY KEY CLUSTERED 
(
	[FormAuthrityRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormDetail](
	[FormDetailId] [int] IDENTITY(1,1) NOT NULL,
	[FormId] [int] NULL,
	[FieldName] [varchar](100) COLLATE Turkish_CI_AS NULL,
	[OrderNo] [int] NOT NULL,
	[FormFieldTypeID] [int] NOT NULL,
	[FieldLength] [int] NULL,
	[FieldIsObligatory] [bit] NOT NULL,
	[IsActive] [bit] NULL,
	[IsFixed] [bit] NULL,
 CONSTRAINT [PK_TblFormDetail] PRIMARY KEY CLUSTERED 
(
	[FormDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormDetailFill]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormDetailFill](
	[FormFillDetailId] [int] IDENTITY(1,1) NOT NULL,
	[FormFillID] [int] NOT NULL,
	[FieldId] [int] NOT NULL,
	[FieldValue] [varchar](150) COLLATE Turkish_CI_AS NULL,
	[ListRowNo] [int] NULL,
 CONSTRAINT [PK_TblFormDetailFill] PRIMARY KEY CLUSTERED 
(
	[FormFillDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormFieldType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormFieldType](
	[FormFieldTypeID] [int] IDENTITY(1,1) NOT NULL,
	[FormFieldName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[FormFieldType] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
 CONSTRAINT [PK_TblFormFieldType] PRIMARY KEY CLUSTERED 
(
	[FormFieldTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormLocation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormLocation](
	[FormLocationID] [int] NOT NULL,
	[FormID] [int] NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_TblFormLocation] PRIMARY KEY CLUSTERED 
(
	[FormLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormMain]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormMain](
	[FormID] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [varchar](100) COLLATE Turkish_CI_AS NULL,
	[DocumentNumber] [varchar](50) COLLATE Turkish_CI_AS NULL,
	[RevisionNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PageNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[RegulationId] [int] NULL,
	[PublishingDate] [datetime] NULL,
	[IsObligatory] [bit] NULL,
	[Explanation] [text] COLLATE Turkish_CI_AS NULL,
	[FormIdentifyEmpID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblFormMain] PRIMARY KEY CLUSTERED 
(
	[FormID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormMainFill]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormMainFill](
	[FormFillId] [int] IDENTITY(1,1) NOT NULL,
	[FormId] [int] NOT NULL,
	[FilledDate] [datetime] NULL,
	[FilledEmployeeID] [int] NULL,
	[FormFilledAttachment] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblFormMainFill] PRIMARY KEY CLUSTERED 
(
	[FormFillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblFormRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblFormRelations](
	[FormRelationId] [int] IDENTITY(1,1) NOT NULL,
	[FormId] [int] NOT NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_TblFormRelations] PRIMARY KEY CLUSTERED 
(
	[FormRelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblInform]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblInform](
	[InformID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK_TblInform] PRIMARY KEY CLUSTERED 
(
	[InformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblInternalAuditPlanInfo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblInternalAuditPlanInfo](
	[InfoID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NOT NULL,
	[ProcedureIDs] [varchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[ProcedureDocumentIDs] [varchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[ManagementID] [int] NOT NULL,
	[ManagementRepresentID] [int] NOT NULL,
	[FollowAuditDate] [date] NULL,
	[RevisionDates] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblInternalAuditPlanInfo] PRIMARY KEY CLUSTERED 
(
	[InfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblInventory]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblInventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryDefID] [int] NULL,
	[SerialNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[ProcurementDate] [date] NULL,
	[ProviderID] [int] NULL,
	[LastDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblInventoryAssignment]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblInventoryAssignment](
	[InAssignmentID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryID] [int] NULL,
	[LocationID] [int] NULL,
	[EmployeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InAssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblInventoryControl]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblInventoryControl](
	[InventoryControlID] [int] IDENTITY(1,1) NOT NULL,
	[ControlDate] [date] NULL,
	[InventoryDefID] [int] NULL,
	[ControllerID] [int] NULL,
	[Result] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[InAssignmentID] [int] NULL,
 CONSTRAINT [PK__TblInven__09144391E2D63B24] PRIMARY KEY CLUSTERED 
(
	[InventoryControlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblInvertoryDef]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblInvertoryDef](
	[InventoryDefID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryDefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabMetots]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabMetots](
	[LabMetotId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabMetots] PRIMARY KEY CLUSTERED 
(
	[LabMetotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneAlimMetot]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneAlimMetot](
	[LabNumuneAlimMetotId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneAlimMetot] PRIMARY KEY CLUSTERED 
(
	[LabNumuneAlimMetotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneAlimSebebi]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneAlimSebebi](
	[LabNumuneAlimSebebiId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneAlimSebebi] PRIMARY KEY CLUSTERED 
(
	[LabNumuneAlimSebebiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneAlimYeri]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneAlimYeri](
	[LabNumuneAlimYeriId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneAlimYeri] PRIMARY KEY CLUSTERED 
(
	[LabNumuneAlimYeriId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneAltGrups]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneAltGrups](
	[LabNumuneAltGrupId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneAltGrups] PRIMARY KEY CLUSTERED 
(
	[LabNumuneAltGrupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneDurum]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneDurum](
	[LabNumuneDurumId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneDurum] PRIMARY KEY CLUSTERED 
(
	[LabNumuneDurumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneGrups]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneGrups](
	[LabNumuneGrupId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneGrups] PRIMARY KEY CLUSTERED 
(
	[LabNumuneGrupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumunePeriyot]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumunePeriyot](
	[LabNumunePeriyotId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumunePeriyot] PRIMARY KEY CLUSTERED 
(
	[LabNumunePeriyotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabNumuneTipi]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabNumuneTipi](
	[LabNumuneTipiId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabNumuneTipi] PRIMARY KEY CLUSTERED 
(
	[LabNumuneTipiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabOperationRequest]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabOperationRequest](
	[LabOperationRequestId] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NOT NULL,
	[LabNumunePeriyotId] [int] NOT NULL,
	[Description] [nvarchar](256) COLLATE Turkish_CI_AS NULL,
	[CustomerWantResults] [bit] NOT NULL,
	[IsConverted] [bit] NOT NULL,
	[IsPassive] [bit] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Created] [smalldatetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModified] [smalldatetime] NULL,
	[LastModifiedBy] [int] NULL,
	[ManagerEmployeeId] [int] NULL,
 CONSTRAINT [PK_TblLabOperationRequest] PRIMARY KEY CLUSTERED 
(
	[LabOperationRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLaboratoryRequest]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLaboratoryRequest](
	[LaboratoryRequestId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[LabPeriyotId] [int] NOT NULL,
	[PlanDate] [smalldatetime] NULL,
	[RequestDate] [smalldatetime] NULL,
	[Description] [nvarchar](256) COLLATE Turkish_CI_AS NULL,
	[ProviderNote] [nvarchar](512) COLLATE Turkish_CI_AS NULL,
	[SenMailToProvider] [bit] NOT NULL,
	[IsPassive] [bit] NOT NULL,
	[Created] [smalldatetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModified] [smalldatetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LocationId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[RelatedId] [int] NULL,
	[ManagerEmployeeId] [int] NULL,
	[ResultStatus] [int] NOT NULL,
	[IsSendDate] [bit] NOT NULL,
	[SendDate] [datetime] NULL,
	[CustomerWantResults] [bit] NOT NULL,
 CONSTRAINT [PK_TblLaboratoryRequest] PRIMARY KEY CLUSTERED 
(
	[LaboratoryRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLaboratoryRequestLine]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLaboratoryRequestLine](
	[LaboratoryRequestLineId] [int] IDENTITY(1,1) NOT NULL,
	[SampleName] [nvarchar](128) COLLATE Turkish_CI_AS NULL,
	[LabNumuneDurumId] [int] NOT NULL,
	[ManufacturingDate] [smalldatetime] NULL,
	[ExpirationDate] [smalldatetime] NULL,
	[BatchNo] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[ManufacturingHour] [smalldatetime] NOT NULL,
	[ProductLabel] [nvarchar](128) COLLATE Turkish_CI_AS NULL,
	[LabNumuneAlimSebebiId] [int] NOT NULL,
	[DeliveryLocation] [int] NOT NULL,
	[OwnerLocation] [int] NOT NULL,
	[BudgeLocation] [int] NOT NULL,
	[ProviderId] [int] NOT NULL,
	[SendDate] [smalldatetime] NULL,
	[ResultDate] [smalldatetime] NULL,
	[Description] [nvarchar](512) COLLATE Turkish_CI_AS NULL,
	[ResultStatus] [int] NOT NULL,
	[LabNumuneTipiId] [int] NOT NULL,
	[ReportLocationNote] [nvarchar](128) COLLATE Turkish_CI_AS NULL,
	[IsSendedToWrite] [bit] NOT NULL,
	[SendedToWtireDate] [smalldatetime] NULL,
	[LaboratoryRequestId] [int] NOT NULL,
 CONSTRAINT [PK_TblLaboratoryRequestLine] PRIMARY KEY CLUSTERED 
(
	[LaboratoryRequestLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLaboratoryRequestLineDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLaboratoryRequestLineDetail](
	[LaboratoryRequestLineDetailId] [int] IDENTITY(1,1) NOT NULL,
	[LaboratoryRequestLineId] [int] NOT NULL,
	[PSPMatchId] [int] NOT NULL,
	[Price] [decimal](18, 8) NOT NULL,
	[Description] [nvarchar](256) COLLATE Turkish_CI_AS NULL,
	[ResultStatus] [int] NOT NULL,
 CONSTRAINT [PK_TblLaboratoryRequestLineDetail] PRIMARY KEY CLUSTERED 
(
	[LaboratoryRequestLineDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLaboratoryRequestPlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLaboratoryRequestPlan](
	[LabRequestPlanId] [int] IDENTITY(1,1) NOT NULL,
	[PlanYear] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModified] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[IsPassive] [bit] NOT NULL,
	[Description] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
 CONSTRAINT [PK_TblLaboratoryRequestPlan] PRIMARY KEY CLUSTERED 
(
	[LabRequestPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLaboratoryRequestPlanLine]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLaboratoryRequestPlanLine](
	[LabRequestPlanLineId] [int] IDENTITY(1,1) NOT NULL,
	[LabRequestPlanId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
	[LabNumuneAlimSebebiId] [int] NOT NULL,
	[SampleName] [nvarchar](128) COLLATE Turkish_CI_AS NULL,
	[ProviderId] [int] NOT NULL,
	[PlanDate] [datetime] NOT NULL,
	[Period] [int] NOT NULL,
	[SamplingMethod] [nvarchar](128) COLLATE Turkish_CI_AS NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[LastModified] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[IsPassive] [bit] NOT NULL,
	[Description] [nvarchar](512) COLLATE Turkish_CI_AS NULL,
	[AlinamamaSebebi] [nvarchar](512) COLLATE Turkish_CI_AS NULL,
	[SampleSatatus] [int] NOT NULL,
 CONSTRAINT [PK_TblLabRequestPlan] PRIMARY KEY CLUSTERED 
(
	[LabRequestPlanLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLaboratoryRequestPlanLineDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLaboratoryRequestPlanLineDetail](
	[LabRequestPlanLineDetailId] [int] IDENTITY(1,1) NOT NULL,
	[LabRequestPlanLineId] [int] NOT NULL,
	[PSPMatchId] [int] NOT NULL,
	[Description] [nvarchar](512) COLLATE Turkish_CI_AS NULL,
	[MonthNo] [int] NOT NULL,
	[SampleSatatus] [int] NOT NULL,
 CONSTRAINT [PK_TblLabRequestPlanDetail] PRIMARY KEY CLUSTERED 
(
	[LabRequestPlanLineDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabParameters]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabParameters](
	[LabParametersId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[Description] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblLabParameters] PRIMARY KEY CLUSTERED 
(
	[LabParametersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLabRequestAnalyseResultFiles]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLabRequestAnalyseResultFiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LabRequest] [int] NOT NULL,
	[Baslik] [nvarchar](270) COLLATE Turkish_CI_AS NOT NULL,
	[DosyaAdi] [nvarchar](350) COLLATE Turkish_CI_AS NOT NULL,
 CONSTRAINT [PK_TblLabRequestAnalyseResultFiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLevel]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLevel](
	[EvidenceLevelId] [int] IDENTITY(1,1) NOT NULL,
	[LevelName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[BreakPoint] [int] NULL,
 CONSTRAINT [PK_TblLevel] PRIMARY KEY CLUSTERED 
(
	[EvidenceLevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationAuditor]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationAuditor](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[AuditorID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationAuditorAttend]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationAuditorAttend](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[AuditorID] [int] NULL,
	[AuditPlanDate] [date] NULL,
	[UpdatedDate] [date] NULL,
	[UpdateBy] [int] NULL,
	[QuestionSetID] [int] NULL,
	[AuditTypeID] [int] NULL,
	[AuditID] [int] NULL,
 CONSTRAINT [PK__TblLocat__2205177E0DB78AD9] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationDemand]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationDemand](
	[LocDemandID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[DemandType] [int] NULL,
	[DemandDate] [date] NULL,
	[Explanation] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
	[ActionType] [int] NULL,
	[CreateDate] [date] NULL,
	[ProjectAddress] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[PeriodExplanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[ContactName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[ContactTelephone] [nvarchar](18) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblLocat__FA02060AE04F1B07] PRIMARY KEY CLUSTERED 
(
	[LocDemandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationDocument]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationDocument](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[DocumentID] [int] NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_TblLocationDocument] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationPoint]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationPoint](
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[TypeDetailId] [int] NOT NULL,
	[TypeName] [nvarchar](130) COLLATE Turkish_CI_AS NULL,
	[YearID] [int] NULL,
	[MonthID] [int] NULL,
	[auditPoint] [float] NULL,
	[CheckListPoint] [float] NULL,
	[QualityPoint] [float] NULL,
	[handPoint] [float] NULL,
	[devicePoint] [float] NULL,
	[majorPoint] [float] NOT NULL,
	[VirtualRegionID] [int] NOT NULL,
	[VirtualRegion] [nvarchar](100) COLLATE Turkish_CI_AS NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationRegion]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationRegion](
	[LocationRegionID] [int] NOT NULL,
	[RegionID] [int] NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_TblLocationRegion] PRIMARY KEY CLUSTERED 
(
	[LocationRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationTypeAuditArea]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationTypeAuditArea](
	[LocAuditAreaID] [int] IDENTITY(1,1) NOT NULL,
	[TypeDetailId] [int] NULL,
	[AuditScopeID] [int] NULL,
 CONSTRAINT [PK_TblLocationTypeAuditArea] PRIMARY KEY CLUSTERED 
(
	[LocAuditAreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationTypeAuditorAttendRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationTypeAuditorAttendRelationship](
	[LocationTypeAuditorAttendRelationshipID] [int] IDENTITY(1,1) NOT NULL,
	[AuditorID] [int] NOT NULL,
	[LocationTypeAuditorAttendID] [int] NOT NULL,
 CONSTRAINT [PK_TblLocationTypeAuditorAttendRelationship] PRIMARY KEY CLUSTERED 
(
	[LocationTypeAuditorAttendRelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblLocationTypeMeasurePlan]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblLocationTypeMeasurePlan](
	[LocTypeMeasPlanID] [int] IDENTITY(1,1) NOT NULL,
	[TypeDetailId] [int] NULL,
	[MeasurementID] [int] NULL,
 CONSTRAINT [PK_TblLocationTypeMeasurePlan] PRIMARY KEY CLUSTERED 
(
	[LocTypeMeasPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMasterRegulation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMasterRegulation](
	[MasterRegulationD] [int] IDENTITY(1,1) NOT NULL,
	[MasterRegulationName] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[PublicationDate] [datetime] NULL,
	[UpdateExplanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[UpdateDate] [datetime] NULL,
	[ControlDate] [datetime] NULL,
	[EmployeeID] [int] NULL,
	[DocumentNo] [nvarchar](15) COLLATE Turkish_CI_AS NULL,
	[MasterRegulationUrl] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[MasterDetailStatue] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblRegulationDetail] PRIMARY KEY CLUSTERED 
(
	[MasterRegulationD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMasterRegulationDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMasterRegulationDetail](
	[MasterRegulationDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[NumberOffNews] [int] NULL,
	[DateOffNews] [date] NULL,
	[RelevantArticle] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[LegalObligation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[AvailableStatue] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[TracingAndMeasStatue] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[NeedToDone] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[Responsible] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[Result] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[MasterRegulationID] [int] NULL,
 CONSTRAINT [PK_TblMasterRegulationDetail] PRIMARY KEY CLUSTERED 
(
	[MasterRegulationDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMaterialServiceAccreditation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMaterialServiceAccreditation](
	[ServiceAccID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialID] [int] NULL,
	[AccSetID] [int] NULL,
	[LocationType] [int] NULL,
 CONSTRAINT [PK_TblMaterialServiceAccreditation] PRIMARY KEY CLUSTERED 
(
	[ServiceAccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMeasDevice]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMeasDevice](
	[MeasDeviceID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblMeasDevice] PRIMARY KEY CLUSTERED 
(
	[MeasDeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMeasurement]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMeasurement](
	[MeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[MeasName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[MeasDeviceID] [int] NULL,
	[MeasLocation] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[MeasCriteriaMax] [float] NULL,
	[MeasCriteriaMin] [float] NULL,
	[MeasCriteria] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[MeasDevice] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblMeasurement] PRIMARY KEY CLUSTERED 
(
	[MeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMessage]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMessage](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[MessageTypeID] [int] NULL,
	[Subject] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Message] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SenderUserID] [int] NULL,
 CONSTRAINT [PK_TblMessage] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMessageDepartmentAuth]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMessageDepartmentAuth](
	[MessageRoleAuthID] [int] IDENTITY(1,1) NOT NULL,
	[SendeRoleID] [int] NULL,
	[ReceiverDepartmentID] [int] NULL,
 CONSTRAINT [PK_TblMessageDeparmentAuth] PRIMARY KEY CLUSTERED 
(
	[MessageRoleAuthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMessageTemplate]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMessageTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[Body] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Code] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[MessageTypeID] [int] NULL,
 CONSTRAINT [PK_TblMessageTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMessageType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMessageType](
	[MessageTypeID] [int] IDENTITY(1,1) NOT NULL,
	[MessageTypeName] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[MessageTypeCode] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[SystmeUserID] [int] NULL,
	[MessageTypeStatue] [bit] NULL,
 CONSTRAINT [PK_TblMessageType] PRIMARY KEY CLUSTERED 
(
	[MessageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMinutesDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMinutesDetail](
	[MinutesDetailID] [int] IDENTITY(1,1) NOT NULL,
	[AudReDetID] [int] NULL,
	[ProductTypeID] [int] NULL,
	[ProductName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[Quantity] [float] NULL,
	[UnitID] [int] NULL,
	[ProcessID] [int] NULL,
	[UnsuitabilitySourceID] [int] NULL,
	[DistortedID] [int] NULL,
	[ProductionDate] [date] NULL,
	[WarehouseEntryDate] [date] NULL,
	[ExpirationDate] [date] NULL,
	[ConfirmDate] [date] NULL,
	[AuditPlanID] [int] NULL,
	[AuditorID] [int] NULL,
	[ServicesMinutesID] [int] NULL,
 CONSTRAINT [PK_TblMinutesDetail] PRIMARY KEY CLUSTERED 
(
	[MinutesDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblMonitoringAndMeasurementPeriod]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblMonitoringAndMeasurementPeriod](
	[MonitoringAndMeasurementPeriodID] [int] IDENTITY(1,1) NOT NULL,
	[MonitoringAndMeasurementID] [int] NULL,
	[Month] [int] NULL,
	[Date] [date] NULL,
	[Control] [bit] NULL,
 CONSTRAINT [PK_TblMonitoringAndMeasurementPeriod] PRIMARY KEY CLUSTERED 
(
	[MonitoringAndMeasurementPeriodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSAdditionalPreventionRiskAssessRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSAdditionalPreventionRiskAssessRelations](
	[AddiPreventionEssessReID] [int] IDENTITY(1,1) NOT NULL,
	[ControlPreventionID] [int] NULL,
	[RiskAssessmentID] [int] NULL,
 CONSTRAINT [PK_TblOHSAdditionalPreventionRiskAssessRelations] PRIMARY KEY CLUSTERED 
(
	[AddiPreventionEssessReID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSDangerSource]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSDangerSource](
	[DangerSourceID] [int] IDENTITY(1,1) NOT NULL,
	[DangerSourceExplanation] [nvarchar](300) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSDangerSource] PRIMARY KEY CLUSTERED 
(
	[DangerSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSEmergencyRootCause]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSEmergencyRootCause](
	[EmergencyRootCauseID] [int] IDENTITY(1,1) NOT NULL,
	[EmergencyID] [int] NULL,
	[RootCauseID] [int] NULL,
 CONSTRAINT [PK_TblOHSEmergencyRootCause] PRIMARY KEY CLUSTERED 
(
	[EmergencyRootCauseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSEmployeeRepresentativeEmpRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSEmployeeRepresentativeEmpRelations](
	[EmployeeRepresentativeEmpRelations] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[RiskAssessmentLocID] [int] NULL,
 CONSTRAINT [PK_TblOHSEmployeeRepresentativeEmpRelations] PRIMARY KEY CLUSTERED 
(
	[EmployeeRepresentativeEmpRelations] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSEquipment_Activity]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSEquipment_Activity](
	[IncKeyNo] [int] IDENTITY(1,1) NOT NULL,
	[Equipment_Activity] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[IsEquipment] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSEquipment_Activity] PRIMARY KEY CLUSTERED 
(
	[IncKeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSMeasurementResponsible]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSMeasurementResponsible](
	[MeasurementResponsibleID] [int] IDENTITY(1,1) NOT NULL,
	[MonitoringAndMeasurementID] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK_TblOHSMeasurementResponsible] PRIMARY KEY CLUSTERED 
(
	[MeasurementResponsibleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSMonitoringAndMeasurement]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSMonitoringAndMeasurement](
	[MonitoringAndMeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[DocumentName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[Foundation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[TakeDate] [date] NULL,
	[ValidityDate] [date] NULL,
	[QuantityControl] [int] NULL,
	[LegalControl] [int] NULL,
	[IncKeyNo] [int] NULL,
	[IsActive] [bit] NULL,
	[ISG_CYS] [bit] NULL,
 CONSTRAINT [PK_TblOHSMonitoringAndMeasurement] PRIMARY KEY CLUSTERED 
(
	[MonitoringAndMeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSMonitoringResponsible]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSMonitoringResponsible](
	[MonitoringResponsibleID] [int] IDENTITY(1,1) NOT NULL,
	[MonitoringAndMeasurementID] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK_TblOHSMonitoringResponsible] PRIMARY KEY CLUSTERED 
(
	[MonitoringResponsibleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRemakWorkAccRootCause]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRemakWorkAccRootCause](
	[RootCauseID] [int] IDENTITY(1,1) NOT NULL,
	[Explanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[RootCauseTypeID] [int] NULL,
	[AccidentTypeID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOHSRemakWorkAccRootCause] PRIMARY KEY CLUSTERED 
(
	[RootCauseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRiskRepresentativeEmployeeRelation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRiskRepresentativeEmployeeRelation](
	[RiskExpertEmployeeReID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[RiskAssessmentLocID] [int] NULL,
 CONSTRAINT [PK_TblOHSRiskExpertEmployeeRelation] PRIMARY KEY CLUSTERED 
(
	[RiskExpertEmployeeReID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRiskSupportEmployeeRelations]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRiskSupportEmployeeRelations](
	[RiskAssessmentEmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[RiskAssessmentLocID] [int] NULL,
 CONSTRAINT [PK_TblOHSRiskAssessEmployeeRelations] PRIMARY KEY CLUSTERED 
(
	[RiskAssessmentEmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSRootCauseType]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSRootCauseType](
	[RootCauseTypeId] [int] IDENTITY(1,1) NOT NULL,
	[RootCauseTypeName] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblOHSRootCauseType] PRIMARY KEY CLUSTERED 
(
	[RootCauseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSWorkAccident]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSWorkAccident](
	[WorkAccidentID] [int] IDENTITY(1,1) NOT NULL,
	[CausaltyEmployeeID] [int] NULL,
	[CausaltyEmployee] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[Duty] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[Date] [datetime] NULL,
	[RegisterNo] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[LocationID] [int] NULL,
	[Accidental] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Statement] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[FirstSuperiorEmpID] [int] NULL,
	[SecondSuperiorEmpID] [int] NULL,
	[FirstSuperiorEmpExplanaion] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SecondSuperiorEmpExplanaion] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[FirstWitnessEmployee] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[SecondWitnessEmployee] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[FirstWitnessEmpExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SecondWitnessEmpExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CasualtyStatement] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[DoctorDiagnostic] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CureResultStatement] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[CureResultID] [int] NULL,
	[AccidentRootCause] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[AccidentPrecaution] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[WorkAccidentEmpSave] [int] NULL,
	[IsActive] [bit] NULL,
	[MajorError] [bit] NULL,
	[WorkingDayLoss] [int] NULL,
	[WorkingHourLoss] [float] NULL,
	[ActionExplanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[DepartmanID] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_TblOHSWorkAccident] PRIMARY KEY CLUSTERED 
(
	[WorkAccidentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSWorkAccidentCureRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSWorkAccidentCureRelationship](
	[WorkAccidentCureID] [int] IDENTITY(1,1) NOT NULL,
	[WorkAccidentID] [int] NULL,
	[CureID] [int] NULL,
 CONSTRAINT [PK_TblOHSWorkAccidentCureRelationship] PRIMARY KEY CLUSTERED 
(
	[WorkAccidentCureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSWorkAccidentRemak]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSWorkAccidentRemak](
	[WorkAccidentSmallID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[WorkAccAndRemakID] [int] NULL,
	[Employee] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[EmployeeDuty] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Date] [datetime] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[AccidentTypeID] [int] NULL,
	[RootCauseID] [int] NULL,
	[CorrectionExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Result] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SaveEmployeeID] [int] NULL,
	[IsActive] [bit] NULL,
	[CloseUpdate] [bit] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK_TblOHSWorkAccidentSmall] PRIMARY KEY CLUSTERED 
(
	[WorkAccidentSmallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOHSWorkAccidentTypeRelationship]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOHSWorkAccidentTypeRelationship](
	[WorkAccidentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[WorkAccidentID] [int] NULL,
	[AccidentTypeID] [int] NULL,
 CONSTRAINT [PK_TblOHSWorkAccidentTypeRelationship] PRIMARY KEY CLUSTERED 
(
	[WorkAccidentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOpeningCorrectiveActivity]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOpeningCorrectiveActivity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ActionExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Reason] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[PlanDate] [date] NULL,
	[RealizedDate] [date] NULL,
	[ConfirmActionStatue] [bit] NULL,
	[LocationId] [int] NULL,
	[DepartmentId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ConfirmDate] [datetime] NULL,
	[RejectionDate] [datetime] NULL,
	[CreatedEmployeeId] [int] NULL,
	[UpdatedEmployeeId] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblOpeningCorrectiveActivity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPerformanceRate]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPerformanceRate](
	[PerformanceRateID] [int] IDENTITY(1,1) NOT NULL,
	[RateByEmpID] [int] NULL,
	[RatedEmpID] [int] NULL,
	[RateDate] [date] NULL,
	[RateNote] [nvarchar](750) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblPerformanceRate] PRIMARY KEY CLUSTERED 
(
	[PerformanceRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPeriodDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPeriodDetail](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[PeriodID] [int] NULL,
	[Frequence] [nvarchar](30) COLLATE Turkish_CI_AS NULL,
	[Period] [int] NULL,
	[FirstTime] [bit] NULL,
 CONSTRAINT [PK__TblPerio__2205177E0D5262D2] PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPeriodicProviderServiceDetail]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPeriodicProviderServiceDetail](
	[ServiceDetailID] [int] IDENTITY(1,1) NOT NULL,
	[PeriodicServiceID] [int] NULL,
	[ProviderServiceID] [int] NULL,
	[IsActive] [bit] NULL,
	[Result] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Statue] [bit] NULL,
	[Price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureActions]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureActions](
	[PleasureActionID] [int] IDENTITY(1,1) NOT NULL,
	[PleasureID] [int] NULL,
	[UserID] [int] NULL,
	[ActionDate] [datetime] NULL,
	[ActionType] [int] NULL,
 CONSTRAINT [PK_TblPleasureActions] PRIMARY KEY CLUSTERED 
(
	[PleasureActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureDocumentRelation]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureDocumentRelation](
	[PleasureDocID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentID] [int] NULL,
	[PleasureID] [int] NULL,
	[IsProof] [bit] NULL,
 CONSTRAINT [PK_TblPleasureDocumentRelation] PRIMARY KEY CLUSTERED 
(
	[PleasureDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureIntoxication]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureIntoxication](
	[IntoxicationID] [int] IDENTITY(1,1) NOT NULL,
	[PleasureID] [int] NULL,
	[SapmleProduct] [bit] NULL,
	[MissingProduct] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[CustomerEvidences] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[SymptonsVomit] [bit] NULL,
	[SymptonsFever] [bit] NULL,
	[SymptonsSickness] [bit] NULL,
	[SymptonsRuns] [bit] NULL,
	[SymptonsStomachAche] [bit] NULL,
	[OtherSymptons] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[CustomerEffect] [int] NULL,
	[CustomerNumber] [int] NULL,
	[EatDate] [date] NULL,
	[SymptonsInfo] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[WentDoctor] [nvarchar](450) COLLATE Turkish_CI_AS NULL,
	[PublicFoods] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[IsSameDepartman] [bit] NULL,
	[OtherEatFoods] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[OtherParty] [nvarchar](400) COLLATE Turkish_CI_AS NULL,
	[Day] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[MealsTime] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK__TblPleas__AD670C216AAF0E4F] PRIMARY KEY CLUSTERED 
(
	[IntoxicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureProvider]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureProvider](
	[PleasureProviderID] [int] IDENTITY(1,1) NOT NULL,
	[PleasureID] [int] NULL,
	[ProviderId] [int] NULL,
	[ProblemType] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[ProblemExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ProductInformations] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[PleasureProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPleasureSubIntoxRealiton]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPleasureSubIntoxRealiton](
	[PleasureSubstanceID] [int] IDENTITY(1,1) NOT NULL,
	[SubstanceID] [int] NULL,
	[IntoxicationID] [int] NULL,
	[PleasureID] [int] NULL,
 CONSTRAINT [PK_TblPleasureSubIntoxRealiton] PRIMARY KEY CLUSTERED 
(
	[PleasureSubstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProcedure]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProcedure](
	[ProcedureID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentProcedureName] [nvarchar](300) COLLATE Turkish_CI_AS NULL,
	[RevisionNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PublishingDate] [date] NULL,
	[DocumentNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[DocumentProcessID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblProcedure] PRIMARY KEY CLUSTERED 
(
	[ProcedureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProcedureDocument]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProcedureDocument](
	[ProcedureDocumentID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[DocumentNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[RevisionNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PageNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[PublishingDate] [date] NULL,
	[ProcedureID] [int] NULL,
	[Explanation] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[RegulationStatue] [bit] NULL,
	[DocumentPath] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
	[ShowDocumentStatue] [bit] NULL,
 CONSTRAINT [PK_TblProcedureDocument] PRIMARY KEY CLUSTERED 
(
	[ProcedureDocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProcess]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProcess](
	[ProcessID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblProcess] PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAccreditionsDocuments]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAccreditionsDocuments](
	[AccDocID] [int] IDENTITY(1,1) NOT NULL,
	[ProvAccID] [int] NULL,
	[DocumentID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[AccDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditExperts]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditExperts](
	[ProvExpertID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCatID] [int] NULL,
	[ExpertID] [int] NULL,
 CONSTRAINT [PK_TblProviderAuditExperts] PRIMARY KEY CLUSTERED 
(
	[ProvExpertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditPeriod]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditPeriod](
	[ProvPeriod] [int] IDENTITY(1,1) NOT NULL,
	[ProductCatID] [int] NULL,
	[PeriodID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblProviderAuditPeriod] PRIMARY KEY CLUSTERED 
(
	[ProvPeriod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditPlanInfo]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditPlanInfo](
	[InfoID] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlanID] [int] NULL,
	[PlannerID] [int] NULL,
	[AuditorChefID] [int] NULL,
	[Explanation] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[InfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditYearPlanItems]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditYearPlanItems](
	[ProviderAuditYearPlanItemID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderAuditYearPlanID] [int] NOT NULL,
	[ProviderID] [int] NOT NULL,
	[AuditorID] [int] NOT NULL,
	[StatuID] [int] NOT NULL,
	[Explanation] [nvarchar](1000) COLLATE Turkish_CI_AS NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
 CONSTRAINT [PK_TblProviderAuditYearPlanItems] PRIMARY KEY CLUSTERED 
(
	[ProviderAuditYearPlanItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditYearPlanItemStatusChanges]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditYearPlanItemStatusChanges](
	[StatusChangeID] [int] IDENTITY(1,1) NOT NULL,
	[PlanItemID] [int] NOT NULL,
	[StatusChangedFrom] [int] NOT NULL,
	[StatusChangedTo] [int] NOT NULL,
	[ChangedEmployeeID] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_TblProviderAuditYearPlanItemStatusChanges] PRIMARY KEY CLUSTERED 
(
	[StatusChangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditYearPlans]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditYearPlans](
	[ProviderAuditYearPlanID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[RevisionCount] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedEmployee] [int] NOT NULL,
	[UpdatedDate] [smalldatetime] NULL,
	[UpdatedEmployee] [int] NULL,
 CONSTRAINT [PK_ProviderAuditYearPlans] PRIMARY KEY CLUSTERED 
(
	[ProviderAuditYearPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderAuditYearPlanStatuses]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderAuditYearPlanStatuses](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__TblProvi__C8EE20438ACC1B1B] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderConsideration]    Script Date: 30.05.2024 17:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderConsideration](
	[ProviderConsiderationID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Period] [char](1) COLLATE Turkish_CI_AS NOT NULL,
	[UnsuibiltyPointMonth1] [float] NULL,
	[UnsuibiltyPointMonth2] [float] NULL,
	[UnsuibiltyPointMonth3] [float] NULL,
	[UnsuibiltyPointMonth4] [float] NULL,
	[UnsuibiltyPointMonth5] [float] NULL,
	[UnsuibiltyPointMonth6] [float] NULL,
	[UnsuibiltyPointAvg] [float] NULL,
	[AuditPointMonth1] [float] NULL,
	[AuditPointMonth2] [float] NULL,
	[AuditPointMonth3] [float] NULL,
	[AuditPointMonth4] [float] NULL,
	[AuditPointMonth5] [float] NULL,
	[AuditPointMonth6] [float] NULL,
	[AuditPointAvg] [float] NULL,
	[OTLPoint] [float] NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedEmployee] [int] NOT NULL,
	[UpdatedEmployee] [int] NULL,
	[UpdatedDate] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProviderConsiderationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderConsiderationParameter]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderConsiderationParameter](
	[ProConsParamID] [int] IDENTITY(1,1) NOT NULL,
	[Group] [varchar](5) COLLATE Turkish_CI_AS NOT NULL,
	[Explanation] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[MinorFactor] [float] NULL,
	[MajorFactor] [float] NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK__TblProvi__F5B99548CB5FB65C] PRIMARY KEY CLUSTERED 
(
	[ProConsParamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderConsiderationPlans]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderConsiderationPlans](
	[ProviderConsiderationPlanId] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[CreatedEmployee] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProviderConsiderationPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderLocation]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderLocation](
	[ProviderID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
 CONSTRAINT [PK_TblProvider_TblLocation] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC,
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderPlannedAuditCounts]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderPlannedAuditCounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[HKYManagerEmployeeID] [int] NOT NULL,
	[PlannedAuditCount] [int] NOT NULL,
 CONSTRAINT [PK__TblProvi__3214EC07C075AE29] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderProblem]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderProblem](
	[ProviderProblemID] [int] IDENTITY(1,1) NOT NULL,
	[DeterminationDate] [datetime] NULL,
	[ShipmentDate] [datetime] NULL,
	[DepartmentId] [int] NULL,
	[LocationID] [int] NULL,
	[ProblemType] [bit] NULL,
	[ProviderID] [int] NOT NULL,
	[Explantion] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ExpirationDate] [datetime] NULL,
	[ProductionDate] [datetime] NULL,
	[PartyNumber] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Result] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[EmployeeID] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[MajorError] [bit] NULL,
	[SurreButter] [bit] NULL,
	[MSB] [bit] NULL,
	[YMNumber] [int] NULL,
	[ProblemReasonID] [int] NULL,
	[CloseUpdate] [bit] NULL,
	[ReferenceNumber] [int] NULL,
	[SendeMail] [bit] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_TblProviderProblem] PRIMARY KEY CLUSTERED 
(
	[ProviderProblemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderProblemDocument]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderProblemDocument](
	[ProviderProblemDocID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[ProviderProblemID] [int] NULL,
	[Path] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[DocumentType] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblProviderProblemDocument] PRIMARY KEY CLUSTERED 
(
	[ProviderProblemDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderProblemEmailEmployee]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderProblemEmailEmployee](
	[ProvEmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[Type] [nchar](10) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblProviderProblemEmailEmployee] PRIMARY KEY CLUSTERED 
(
	[ProvEmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderProblemImpurityRelationship]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderProblemImpurityRelationship](
	[ProviderProImpurityID] [int] IDENTITY(1,1) NOT NULL,
	[ImpurityID] [int] NULL,
	[ProviderProblemID] [int] NULL,
 CONSTRAINT [PK_TblProviderProblemImpurityRelationship] PRIMARY KEY CLUSTERED 
(
	[ProviderProImpurityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderQuestionSet]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderQuestionSet](
	[ProviderSetID] [int] IDENTITY(1,1) NOT NULL,
	[SetID] [int] NULL,
	[CatID] [int] NULL,
 CONSTRAINT [PK_TblProviderQuestionSet] PRIMARY KEY CLUSTERED 
(
	[ProviderSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderRegion]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderRegion](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[RegionName] [varchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Explantion] [varchar](100) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProviderRegion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderRegionRelationship]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderRegionRelationship](
	[ProviderID] [int] NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_TblProviderRegionRelationship] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC,
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProviderServicePlanDetail]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProviderServicePlanDetail](
	[ServiceDetID] [int] IDENTITY(1,1) NOT NULL,
	[CatId] [int] NULL,
	[PlanID] [int] NULL,
	[MaterialID] [int] NULL,
	[RealDate] [date] NULL,
	[ServiceDate] [date] NULL,
	[PlanDate] [date] NULL,
	[Result] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Status] [bit] NULL,
	[EvidenceID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ChargedPrice] [float] NULL,
 CONSTRAINT [PK__TblProci__AA50CDC942D5AD4D] PRIMARY KEY CLUSTERED 
(
	[ServiceDetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProvideSampleParametersMatchs]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProvideSampleParametersMatchs](
	[PSpMatchId] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NOT NULL,
	[LabNumuneGrupId] [int] NOT NULL,
	[LabNumuneAltGrupId] [int] NOT NULL,
	[LabMetotId] [int] NOT NULL,
	[LabParametersId] [int] NOT NULL,
	[IsSpecial] [bit] NOT NULL,
	[Price] [decimal](18, 8) NOT NULL,
	[Description] [nvarchar](256) COLLATE Turkish_CI_AS NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[UpdateDate] [smalldatetime] NULL,
	[UpdatedBy] [int] NULL,
	[IsPassive] [bit] NOT NULL,
 CONSTRAINT [PK_TblProvideSampleParametersMatchs] PRIMARY KEY CLUSTERED 
(
	[PSpMatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblPspMatchPriceTransactions]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblPspMatchPriceTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PSpMatchId] [int] NOT NULL,
	[OldPrice] [decimal](18, 8) NOT NULL,
	[CrateDate] [smalldatetime] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_TblPspMatchPriceTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblQuesSetFormInfo]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuesSetFormInfo](
	[SetInfoID] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[DocumentNumber] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[ReleaseDate] [nvarchar](250) COLLATE Turkish_CI_AS NULL,
	[RevisionNumber] [nvarchar](10) COLLATE Turkish_CI_AS NULL,
	[PageNumber] [nvarchar](10) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblQuesSetFormInfo] PRIMARY KEY CLUSTERED 
(
	[SetInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblQuestionScale]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuestionScale](
	[ScaleID] [int] IDENTITY(1,1) NOT NULL,
	[ScaleName] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[ScaleValue] [int] NULL,
 CONSTRAINT [PK_TblQScale] PRIMARY KEY CLUSTERED 
(
	[ScaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblQuestionScaleDetail]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblQuestionScaleDetail](
	[ScaleDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DetailName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[ScaleID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblScaleDetail] PRIMARY KEY CLUSTERED 
(
	[ScaleDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblReceiverUserMessage]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblReceiverUserMessage](
	[ReceiverUserMessageID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[MessageTypeID] [int] NULL,
 CONSTRAINT [PK_TblReceiverUserMessage] PRIMARY KEY CLUSTERED 
(
	[ReceiverUserMessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblRequester]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRequester](
	[RequesterID] [int] IDENTITY(1,1) NOT NULL,
	[RequesterTypeID] [int] NULL,
 CONSTRAINT [PK_TblRequester] PRIMARY KEY CLUSTERED 
(
	[RequesterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblServiceProcess]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblServiceProcess](
	[ProcessID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblServiceProcess] PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblServicesMinutes]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblServicesMinutes](
	[ServicesMinutesID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[EmployeeID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
	[Statue] [bit] NULL,
	[Date] [date] NULL,
	[ConfirmEmployee] [int] NULL,
	[MinutesExplanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblLocationMinutes] PRIMARY KEY CLUSTERED 
(
	[ServicesMinutesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSourceTask]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSourceTask](
	[SourceTaskID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NULL,
	[SourceID] [int] NULL,
	[SourceModul] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[TaskID] [int] NULL,
 CONSTRAINT [PK_TblSourceTask] PRIMARY KEY CLUSTERED 
(
	[SourceTaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSuggest]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSuggest](
	[SuggestID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[RequesterID] [int] NULL,
	[TransDate] [date] NULL,
	[SuggestTypeID] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[Category] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[ResponsibleID] [int] NULL,
	[TaskID] [int] NULL,
	[Point] [int] NULL,
	[IsFinished] [bit] NULL,
	[ISReturned] [bit] NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK__TblCompA__24421B29647E4B70] PRIMARY KEY CLUSTERED 
(
	[SuggestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurvey]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurvey](
	[SurveyId] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NULL,
	[SurveyorId] [int] NULL,
	[DateTime] [datetime] NULL,
	[SurveyTypeId] [int] NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[SaveEmployeeId] [int] NULL,
	[DateTime-Yedek] [datetime] NULL,
 CONSTRAINT [PK_TblSurvey] PRIMARY KEY CLUSTERED 
(
	[SurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyAnswer]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyAnswer](
	[SurveyAnswerId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NULL,
	[TypeId] [int] NULL,
	[SurveyId] [int] NULL,
 CONSTRAINT [PK_TblSurveyAnswer] PRIMARY KEY CLUSTERED 
(
	[SurveyAnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyAnswerType]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyAnswerType](
	[AnswerTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[AnswerValue] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblSurveyAnswerType] PRIMARY KEY CLUSTERED 
(
	[AnswerTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyor]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyor](
	[SurveyorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Email] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[CompanyAddress] [nvarchar](200) COLLATE Turkish_CI_AS NULL,
	[Fax] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[Title] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[PhoneNumber] [int] NULL,
 CONSTRAINT [PK_TblSurveyor] PRIMARY KEY CLUSTERED 
(
	[SurveyorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyQuestion]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyQuestion](
	[SurveyQuestionId] [int] IDENTITY(1,1) NOT NULL,
	[TitleId] [int] NULL,
	[Name] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Text] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblSurveyQuestion] PRIMARY KEY CLUSTERED 
(
	[SurveyQuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyQuestionTitle]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyQuestionTitle](
	[QuestionTitleId] [int] IDENTITY(1,1) NOT NULL,
	[TitleName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblSurveyQuestionTitle] PRIMARY KEY CLUSTERED 
(
	[QuestionTitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyTitleType]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyTitleType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionTitleId] [int] NULL,
	[SurveyTypeId] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblSurveyTitleType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSurveyType]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSurveyType](
	[SurveyTypeId] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TblSurveyType] PRIMARY KEY CLUSTERED 
(
	[SurveyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTabMenuItem]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTabMenuItem](
	[TabMenuItemID] [int] IDENTITY(1,1) NOT NULL,
	[TabMenuItemName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblTabMenuItem] PRIMARY KEY CLUSTERED 
(
	[TabMenuItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTanimlama]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTanimlama](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tip] [int] NOT NULL,
	[TipAdi] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Deger] [nvarchar](250) COLLATE Turkish_CI_AS NOT NULL,
	[Sira] [int] NOT NULL,
 CONSTRAINT [PK_TblTanimlama] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTargetAttend]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTargetAttend](
	[TargetAttendID] [int] IDENTITY(1,1) NOT NULL,
	[AttendID] [int] NULL,
	[TargetTypeID] [int] NULL,
	[TargetID] [int] NULL,
	[TargetDueDate] [date] NULL,
	[TargetValue] [int] NULL,
	[RealizedValue] [int] NULL,
 CONSTRAINT [PK__TblTarge__781C1F6B5BCDC35B] PRIMARY KEY CLUSTERED 
(
	[TargetAttendID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTargetMeasurement]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTargetMeasurement](
	[TargetMeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[TargetID] [int] NULL,
	[RealizedDate] [date] NULL,
	[MeasRealizeValue] [float] NULL,
 CONSTRAINT [PK_TblTargetMeasurement] PRIMARY KEY CLUSTERED 
(
	[TargetMeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTask]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTask](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskName] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[StartDate] [date] NULL,
	[FinishDate] [date] NULL,
	[RealizeFinishDate] [date] NULL,
	[Status] [int] NULL,
	[EmployeeID] [int] NULL,
 CONSTRAINT [PK__TblTask__7C6949D1E93EB049] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTempGroupMajor]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTempGroupMajor](
	[GroupMajorID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NULL,
	[LevelID] [int] NULL,
	[QuestionID] [int] NULL,
	[AuditReDetID] [int] NULL,
	[IsRegulatoryActivity] [bit] NULL,
	[AuditPlanID] [int] NULL,
 CONSTRAINT [PK_TblTempGroupMajor] PRIMARY KEY CLUSTERED 
(
	[GroupMajorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTrainers]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTrainers](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[TrainingID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTraining]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTraining](
	[TrainingID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[Explanation] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[IsObligatory] [bit] NULL,
	[PeriodID] [int] NULL,
	[DocumentID] [int] NULL,
	[TrainingTypeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TrainingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTrainingAssignments]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTrainingAssignments](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[TrainingID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblTrainingPlan]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblTrainingPlan](
	[InckeyNo] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[TrainingID] [int] NULL,
	[PlanDate] [date] NULL,
	[RealizedDate] [date] NULL,
	[TrainerID] [int] NULL,
	[TrainingPlanTypeID] [int] NULL,
	[TrainingDuration] [int] NULL,
	[CertificateID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InckeyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUnsuitabilitySource]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUnsuitabilitySource](
	[UnsuitabilitySourceID] [int] IDENTITY(1,1) NOT NULL,
	[UnsuitabilitySourceName] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_TblUnsuitabilitySource] PRIMARY KEY CLUSTERED 
(
	[UnsuitabilitySourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUnsuitabilityTitle]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUnsuitabilityTitle](
	[TitleId] [int] IDENTITY(1,1) NOT NULL,
	[TitleName] [nvarchar](150) COLLATE Turkish_CI_AS NOT NULL,
	[Explanation] [nvarchar](255) COLLATE Turkish_CI_AS NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TblUnsuitabilityTitle] PRIMARY KEY CLUSTERED 
(
	[TitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUpdateFormEmpRelations]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUpdateFormEmpRelations](
	[UpdateFormEmpID] [int] IDENTITY(1,1) NOT NULL,
	[FormID] [int] NULL,
	[EmployeeID] [int] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_TblUpdateFormEmpRelations] PRIMARY KEY CLUSTERED 
(
	[UpdateFormEmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblVirtualManagement]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblVirtualManagement](
	[VManageID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[VirtualRegionID] [int] NULL,
 CONSTRAINT [PK_TblVirtualManagemet] PRIMARY KEY CLUSTERED 
(
	[VManageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tedarikciData]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tedarikciData](
	[ProviderName] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[HizmetGrubu] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[SanalBolge] [nvarchar](500) COLLATE Turkish_CI_AS NULL,
	[Onay] [bit] NULL,
	[aktif] [bit] NULL,
	[calismaTipi] [nvarchar](50) COLLATE Turkish_CI_AS NULL,
	[itelisimSahibi] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[eMail] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[tel] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[mobile] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[adres] [nvarchar](550) COLLATE Turkish_CI_AS NULL,
	[sehir] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[ilce] [nvarchar](150) COLLATE Turkish_CI_AS NULL,
	[aciklama] [nvarchar](450) COLLATE Turkish_CI_AS NULL,
	[hizmetID] [int] NULL,
	[sanalID] [int] NULL,
	[ProviderID] [int] NULL,
	[MaterialName] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[CatID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Value] [smallint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Counter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Field] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Value] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StateId] [int] NULL,
	[StateName] [nvarchar](20) COLLATE Turkish_CI_AS NULL,
	[InvocationData] [nvarchar](max) COLLATE Turkish_CI_AS NOT NULL,
	[Arguments] [nvarchar](max) COLLATE Turkish_CI_AS NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [int] NOT NULL,
	[Name] [nvarchar](40) COLLATE Turkish_CI_AS NOT NULL,
	[Value] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [int] NOT NULL,
	[Queue] [nvarchar](50) COLLATE Turkish_CI_AS NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Value] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Data] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) COLLATE Turkish_CI_AS NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) COLLATE Turkish_CI_AS NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [int] NOT NULL,
	[Name] [nvarchar](20) COLLATE Turkish_CI_AS NOT NULL,
	[Reason] [nvarchar](100) COLLATE Turkish_CI_AS NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) COLLATE Turkish_CI_AS NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IND_FILTER]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IND_FILTER] ON [dbo].[TblAuditedDevice]
(
	[AuditPlanID] ASC,
	[NonAudit] ASC,
	[Statue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IND_FILTER_TblAuditedHands]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IND_FILTER_TblAuditedHands] ON [dbo].[TblAuditedHands]
(
	[AuditPlanID] ASC,
	[NonAudit] ASC,
	[Statue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditorAuditPlan_AuditPlanID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditorAuditPlan_AuditPlanID] ON [dbo].[TblAuditorAuditPlan]
(
	[AuditPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditPlan_AuditDate]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditPlan_AuditDate] ON [dbo].[TblAuditPlan]
(
	[AuditDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditPlan_AuditTypeID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditPlan_AuditTypeID] ON [dbo].[TblAuditPlan]
(
	[AuditTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditPlan_LocationID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditPlan_LocationID] ON [dbo].[TblAuditPlan]
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditRealize_AuditPlanID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditRealize_AuditPlanID] ON [dbo].[TblAuditRealize]
(
	[AuditPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditRealizeDetail_AuditPlanID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditRealizeDetail_AuditPlanID] ON [dbo].[TblAuditRealizeDetail]
(
	[AuditPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblAuditRealizeDetail_QuestionID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblAuditRealizeDetail_QuestionID] ON [dbo].[TblAuditRealizeDetail]
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_TblHandAndDeviceCorrective_AuditPlanID]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IDX_TblHandAndDeviceCorrective_AuditPlanID] ON [dbo].[TblHandAndDeviceCorrective]
(
	[AuditPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_HangFire_CounterAggregated_Key]    Script Date: 30.05.2024 17:22:53 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_HangFire_CounterAggregated_Key] ON [HangFire].[AggregatedCounter]
(
	[Key] ASC
)
INCLUDE([Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Counter_Key]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Counter_Key] ON [HangFire].[Counter]
(
	[Key] ASC
)
INCLUDE([Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
INCLUDE([Id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Hash_Key]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_Key] ON [HangFire].[Hash]
(
	[Key] ASC
)
INCLUDE([ExpireAt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_HangFire_Hash_Key_Field]    Script Date: 30.05.2024 17:22:53 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_HangFire_Hash_Key_Field] ON [HangFire].[Hash]
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([Id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_JobParameter_JobIdAndName]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_JobParameter_JobIdAndName] ON [HangFire].[JobParameter]
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_JobQueue_QueueAndFetchedAt]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_JobQueue_QueueAndFetchedAt] ON [HangFire].[JobQueue]
(
	[Queue] ASC,
	[FetchedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
INCLUDE([Id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_List_Key]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_Key] ON [HangFire].[List]
(
	[Key] ASC
)
INCLUDE([ExpireAt],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
INCLUDE([Id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Key]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Key] ON [HangFire].[Set]
(
	[Key] ASC
)
INCLUDE([ExpireAt],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_HangFire_Set_KeyAndValue]    Script Date: 30.05.2024 17:22:53 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_HangFire_Set_KeyAndValue] ON [HangFire].[Set]
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_State_JobId]    Script Date: 30.05.2024 17:22:53 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_State_JobId] ON [HangFire].[State]
(
	[JobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] ADD  DEFAULT ((1)) FOR [PrivRead]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] ADD  DEFAULT ((0)) FOR [PrivUpdate]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] ADD  DEFAULT ((0)) FOR [PrivDelete]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] ADD  DEFAULT ((0)) FOR [PrivInsert]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] ADD  DEFAULT ((0)) FOR [PrivFull]
GO
ALTER TABLE [dbo].[TblAudit] ADD  CONSTRAINT [DF__TblAudit__IsActi__2C3393D0]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblAuditLocations] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblAuditor] ADD  CONSTRAINT [DF_TblAuditor_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblAuditPlan] ADD  CONSTRAINT [DF__TblAuditP__IsAct__671F4F74]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail] ADD  DEFAULT ((0)) FOR [ImgStatue]
GO
ALTER TABLE [dbo].[TblAuditType] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblAuditTypeRelationship] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblCertificate] ADD  DEFAULT ((0)) FOR [IsObligatory]
GO
ALTER TABLE [dbo].[TblDosya] ADD  CONSTRAINT [DF_TblDosya_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblDosya] ADD  CONSTRAINT [DF_TblDosya_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TblEmployee] ADD  CONSTRAINT [DF__TblEmploy__IsAct__21B6055D]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblFormAuthority] ADD  CONSTRAINT [DF_TblFormAuthority_FormUpdate]  DEFAULT ((0)) FOR [FormUpdate]
GO
ALTER TABLE [dbo].[TblFormAuthority] ADD  CONSTRAINT [DF_TblFormAuthority_FormShow]  DEFAULT ((0)) FOR [FormShow]
GO
ALTER TABLE [dbo].[TblFormAuthority] ADD  CONSTRAINT [DF_TblFormAuthority_FormDelete]  DEFAULT ((0)) FOR [FormDelete]
GO
ALTER TABLE [dbo].[TblFormAuthority] ADD  CONSTRAINT [DF_TblFormAuthority_FormFill]  DEFAULT ((0)) FOR [FormFill]
GO
ALTER TABLE [dbo].[TblFormAuthority] ADD  CONSTRAINT [DF_TblFormAuthority_FormExport]  DEFAULT ((0)) FOR [FormExport]
GO
ALTER TABLE [dbo].[TblFormAuthority] ADD  CONSTRAINT [DF_TblFormAuthority_FormShowList]  DEFAULT ((0)) FOR [FormShowList]
GO
ALTER TABLE [dbo].[TblLaboratoryRequest] ADD  CONSTRAINT [DF_TblLaboratoryRequest_IsSendDate]  DEFAULT ((0)) FOR [IsSendDate]
GO
ALTER TABLE [dbo].[TblLaboratoryRequest] ADD  CONSTRAINT [DF_TblLaboratoryRequest_CustomerWantResults]  DEFAULT ((0)) FOR [CustomerWantResults]
GO
ALTER TABLE [dbo].[TblLocation] ADD  CONSTRAINT [DF__TblLocati__IsAct__1CF15040]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblMeasurement] ADD  CONSTRAINT [DF__TblMeasur__IsAct__0A9D95DB]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblQuestion] ADD  CONSTRAINT [DF__TblQuesti__ToBeI__0F975522]  DEFAULT ((0)) FOR [ToBeInform]
GO
ALTER TABLE [dbo].[TblRegulation] ADD  CONSTRAINT [DF__TblRegula__IsAct__7849DB76]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblTowns] ADD  CONSTRAINT [DF__TblTowns__il_id__473C8FC7]  DEFAULT (NULL) FOR [CityID]
GO
ALTER TABLE [dbo].[AuditEntryProperties]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AuditEntryProperties_dbo.AuditEntries_AuditEntryID] FOREIGN KEY([AuditEntryID])
REFERENCES [dbo].[AuditEntries] ([AuditEntryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AuditEntryProperties] CHECK CONSTRAINT [FK_dbo.AuditEntryProperties_dbo.AuditEntries_AuditEntryID]
GO
ALTER TABLE [dbo].[TblAccrdtAssn]  WITH CHECK ADD  CONSTRAINT [FK_TblAccrdtAssn_TblAccreditation] FOREIGN KEY([AccID])
REFERENCES [dbo].[TblAccreditation] ([AccID])
GO
ALTER TABLE [dbo].[TblAccrdtAssn] CHECK CONSTRAINT [FK_TblAccrdtAssn_TblAccreditation]
GO
ALTER TABLE [dbo].[TblAccrdtAssn]  WITH CHECK ADD  CONSTRAINT [FK_TblAccrdtAssn_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblAccrdtAssn] CHECK CONSTRAINT [FK_TblAccrdtAssn_TblDocument]
GO
ALTER TABLE [dbo].[TblAccrdtAssn]  WITH CHECK ADD  CONSTRAINT [FK_TblAccrdtAssn_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblAccrdtAssn] CHECK CONSTRAINT [FK_TblAccrdtAssn_TblLocation]
GO
ALTER TABLE [dbo].[TblAccrdtAssn]  WITH CHECK ADD  CONSTRAINT [FK_TblAccrdtAssn_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblAccrdtAssn] CHECK CONSTRAINT [FK_TblAccrdtAssn_TblProvider]
GO
ALTER TABLE [dbo].[TblAccrdtAssn]  WITH CHECK ADD  CONSTRAINT [FK_TblAccrdtAssn_TblProviderServices] FOREIGN KEY([ProviderServiceID])
REFERENCES [dbo].[TblProviderServices] ([ProviderServiceID])
GO
ALTER TABLE [dbo].[TblAccrdtAssn] CHECK CONSTRAINT [FK_TblAccrdtAssn_TblProviderServices]
GO
ALTER TABLE [dbo].[TblAccreditation]  WITH CHECK ADD  CONSTRAINT [FK_TblAccreditation_TblAccSet] FOREIGN KEY([AccSetID])
REFERENCES [dbo].[TblAccSet] ([AccSetID])
GO
ALTER TABLE [dbo].[TblAccreditation] CHECK CONSTRAINT [FK_TblAccreditation_TblAccSet]
GO
ALTER TABLE [dbo].[TblAccSet]  WITH CHECK ADD  CONSTRAINT [FK_TblAccSet_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblAccSet] CHECK CONSTRAINT [FK_TblAccSet_TblDocument]
GO
ALTER TABLE [dbo].[TblAccSet]  WITH CHECK ADD  CONSTRAINT [FK_TblAccSet_TblRegulation] FOREIGN KEY([RegulationID])
REFERENCES [dbo].[TblRegulation] ([RegulationID])
GO
ALTER TABLE [dbo].[TblAccSet] CHECK CONSTRAINT [FK_TblAccSet_TblRegulation]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege]  WITH CHECK ADD  CONSTRAINT [FK_TblAppRolePrivilege_TblAppPrivilege] FOREIGN KEY([AppPrivilegeID])
REFERENCES [dbo].[TblAppPrivilege] ([AppPrivilegeID])
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] CHECK CONSTRAINT [FK_TblAppRolePrivilege_TblAppPrivilege]
GO
ALTER TABLE [dbo].[TblAppRolePrivilege]  WITH CHECK ADD  CONSTRAINT [FK_TblAppRolePrivilege_TblRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblAppRolePrivilege] CHECK CONSTRAINT [FK_TblAppRolePrivilege_TblRoles]
GO
ALTER TABLE [dbo].[TblAppRoleSubMenuItemRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblAppRoleSubMenuItemRelationship_TblAppSubMenuItem] FOREIGN KEY([SubMenuItemID])
REFERENCES [dbo].[TblAppSubMenuItem] ([SubMenuItemID])
GO
ALTER TABLE [dbo].[TblAppRoleSubMenuItemRelationship] CHECK CONSTRAINT [FK_TblAppRoleSubMenuItemRelationship_TblAppSubMenuItem]
GO
ALTER TABLE [dbo].[TblAppRoleSubMenuItemRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblAppRoleSubMenuItemRelationship_TblRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblAppRoleSubMenuItemRelationship] CHECK CONSTRAINT [FK_TblAppRoleSubMenuItemRelationship_TblRoles]
GO
ALTER TABLE [dbo].[TblAppSubMenu]  WITH CHECK ADD  CONSTRAINT [FK_TblAppSubMenu_TblAppMenu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[TblAppMenu] ([MenuID])
GO
ALTER TABLE [dbo].[TblAppSubMenu] CHECK CONSTRAINT [FK_TblAppSubMenu_TblAppMenu]
GO
ALTER TABLE [dbo].[TblAppSubMenuItem]  WITH CHECK ADD  CONSTRAINT [FK_TblAppSubMenuItem_TblTabMenuItem] FOREIGN KEY([TabMenuItemID])
REFERENCES [dbo].[TblTabMenuItem] ([TabMenuItemID])
GO
ALTER TABLE [dbo].[TblAppSubMenuItem] CHECK CONSTRAINT [FK_TblAppSubMenuItem_TblTabMenuItem]
GO
ALTER TABLE [dbo].[TblAppSubMenuItemRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblAppSubMenuItemRelationship_TblAppSubMenu] FOREIGN KEY([SubMenuID])
REFERENCES [dbo].[TblAppSubMenu] ([SubMenuID])
GO
ALTER TABLE [dbo].[TblAppSubMenuItemRelationship] CHECK CONSTRAINT [FK_TblAppSubMenuItemRelationship_TblAppSubMenu]
GO
ALTER TABLE [dbo].[TblAppSubMenuItemRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblAppSubMenuItemRelationship_TblAppSubMenuItem] FOREIGN KEY([SubMenuItemID])
REFERENCES [dbo].[TblAppSubMenuItem] ([SubMenuItemID])
GO
ALTER TABLE [dbo].[TblAppSubMenuItemRelationship] CHECK CONSTRAINT [FK_TblAppSubMenuItemRelationship_TblAppSubMenuItem]
GO
ALTER TABLE [dbo].[TblAttendProviderServiceLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblAttendProviderServiceLocation_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblAttendProviderServiceLocation] CHECK CONSTRAINT [FK_TblAttendProviderServiceLocation_TblLocation]
GO
ALTER TABLE [dbo].[TblAttendProviderServiceLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblAttendProviderServiceLocation_TblProviderServices] FOREIGN KEY([ProviderServiceID])
REFERENCES [dbo].[TblProviderServices] ([ProviderServiceID])
GO
ALTER TABLE [dbo].[TblAttendProviderServiceLocation] CHECK CONSTRAINT [FK_TblAttendProviderServiceLocation_TblProviderServices]
GO
ALTER TABLE [dbo].[TblAudit]  WITH CHECK ADD  CONSTRAINT [FK_TblAudit_TblRegulation] FOREIGN KEY([RegulationID])
REFERENCES [dbo].[TblRegulation] ([RegulationID])
GO
ALTER TABLE [dbo].[TblAudit] CHECK CONSTRAINT [FK_TblAudit_TblRegulation]
GO
ALTER TABLE [dbo].[TblAuditAreaPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditAreaPlan_TblAuditArea] FOREIGN KEY([AuditScopeID])
REFERENCES [dbo].[TblAuditArea] ([AuditScopeID])
GO
ALTER TABLE [dbo].[TblAuditAreaPlan] CHECK CONSTRAINT [FK_TblAuditAreaPlan_TblAuditArea]
GO
ALTER TABLE [dbo].[TblAuditAreaPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditAreaPlan_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditAreaPlan] CHECK CONSTRAINT [FK_TblAuditAreaPlan_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditAveragePoint]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditAveragePoint_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblAuditAveragePoint] CHECK CONSTRAINT [FK_TblAuditAveragePoint_TblLocation]
GO
ALTER TABLE [dbo].[TblAuditAveragePoint]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditAveragePoint_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblAuditAveragePoint] CHECK CONSTRAINT [FK_TblAuditAveragePoint_TblProvider]
GO
ALTER TABLE [dbo].[TblAuditedDevice]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedDevice_TblAuditArea] FOREIGN KEY([AreaID])
REFERENCES [dbo].[TblAuditArea] ([AuditScopeID])
GO
ALTER TABLE [dbo].[TblAuditedDevice] CHECK CONSTRAINT [FK_TblAuditedDevice_TblAuditArea]
GO
ALTER TABLE [dbo].[TblAuditedDevice]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedDevice_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditedDevice] CHECK CONSTRAINT [FK_TblAuditedDevice_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditedDevice]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedDevice_TblDevices] FOREIGN KEY([DeviceID])
REFERENCES [dbo].[TblDevices] ([DeviceID])
GO
ALTER TABLE [dbo].[TblAuditedDevice] CHECK CONSTRAINT [FK_TblAuditedDevice_TblDevices]
GO
ALTER TABLE [dbo].[TblAuditedDevice]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedDevice_TblServiceProcess] FOREIGN KEY([ProcessID])
REFERENCES [dbo].[TblServiceProcess] ([ProcessID])
GO
ALTER TABLE [dbo].[TblAuditedDevice] CHECK CONSTRAINT [FK_TblAuditedDevice_TblServiceProcess]
GO
ALTER TABLE [dbo].[TblAuditedHands]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedHands_TblAuditArea] FOREIGN KEY([AreaID])
REFERENCES [dbo].[TblAuditArea] ([AuditScopeID])
GO
ALTER TABLE [dbo].[TblAuditedHands] CHECK CONSTRAINT [FK_TblAuditedHands_TblAuditArea]
GO
ALTER TABLE [dbo].[TblAuditedHands]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedHands_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditedHands] CHECK CONSTRAINT [FK_TblAuditedHands_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditedHands]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditedHands_TblServiceProcess] FOREIGN KEY([ProcessID])
REFERENCES [dbo].[TblServiceProcess] ([ProcessID])
GO
ALTER TABLE [dbo].[TblAuditedHands] CHECK CONSTRAINT [FK_TblAuditedHands_TblServiceProcess]
GO
ALTER TABLE [dbo].[TblAuditLocations]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditLocations_TblAuditType] FOREIGN KEY([AuditTypeID])
REFERENCES [dbo].[TblAuditType] ([AuditTypeID])
GO
ALTER TABLE [dbo].[TblAuditLocations] CHECK CONSTRAINT [FK_TblAuditLocations_TblAuditType]
GO
ALTER TABLE [dbo].[TblAuditLocations]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditLocations_TblExpert] FOREIGN KEY([ExpertID])
REFERENCES [dbo].[TblExpert] ([ExpertID])
GO
ALTER TABLE [dbo].[TblAuditLocations] CHECK CONSTRAINT [FK_TblAuditLocations_TblExpert]
GO
ALTER TABLE [dbo].[TblAuditLocations]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditLocations_TblTypeDetail] FOREIGN KEY([LocationTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblAuditLocations] CHECK CONSTRAINT [FK_TblAuditLocations_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblAuditMeasurePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditMeasurePlan_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditMeasurePlan] CHECK CONSTRAINT [FK_TblAuditMeasurePlan_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditMeasurePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditMeasurePlan_TblMeasurement] FOREIGN KEY([MeasurementID])
REFERENCES [dbo].[TblMeasurement] ([MeasurementID])
GO
ALTER TABLE [dbo].[TblAuditMeasurePlan] CHECK CONSTRAINT [FK_TblAuditMeasurePlan_TblMeasurement]
GO
ALTER TABLE [dbo].[TblAuditor]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditor_TblEmployee2] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblAuditor] CHECK CONSTRAINT [FK_TblAuditor_TblEmployee2]
GO
ALTER TABLE [dbo].[TblAuditor]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditor_TblVirtualRegion] FOREIGN KEY([VirtualRegionID])
REFERENCES [dbo].[TblVirtualRegion] ([VirtualRegionID])
GO
ALTER TABLE [dbo].[TblAuditor] CHECK CONSTRAINT [FK_TblAuditor_TblVirtualRegion]
GO
ALTER TABLE [dbo].[TblAuditorAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditorAuditPlan_TblAuditor] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblAuditorAuditPlan] CHECK CONSTRAINT [FK_TblAuditorAuditPlan_TblAuditor]
GO
ALTER TABLE [dbo].[TblAuditorAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditorAuditPlan_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditorAuditPlan] CHECK CONSTRAINT [FK_TblAuditorAuditPlan_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblAudit] FOREIGN KEY([AuditID])
REFERENCES [dbo].[TblAudit] ([AuditID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblAudit]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblAuditType] FOREIGN KEY([AuditTypeID])
REFERENCES [dbo].[TblAuditType] ([AuditTypeID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblAuditType]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblLocation]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblPeriod] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[TblPeriod] ([PeriodID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblPeriod]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblProductCategory] FOREIGN KEY([ProductCatID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblProductCategory]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblProvider]
GO
ALTER TABLE [dbo].[TblAuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditPlan_TblQuestionSet] FOREIGN KEY([QuesSetTypeID])
REFERENCES [dbo].[TblQuestionSet] ([SetID])
GO
ALTER TABLE [dbo].[TblAuditPlan] CHECK CONSTRAINT [FK_TblAuditPlan_TblQuestionSet]
GO
ALTER TABLE [dbo].[TblAuditProviderRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditProviderRelations_TblAuditType] FOREIGN KEY([AuditTypeID])
REFERENCES [dbo].[TblAuditType] ([AuditTypeID])
GO
ALTER TABLE [dbo].[TblAuditProviderRelations] CHECK CONSTRAINT [FK_TblAuditProviderRelations_TblAuditType]
GO
ALTER TABLE [dbo].[TblAuditProviderRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditProviderRelations_TblExpert] FOREIGN KEY([ExpertID])
REFERENCES [dbo].[TblExpert] ([ExpertID])
GO
ALTER TABLE [dbo].[TblAuditProviderRelations] CHECK CONSTRAINT [FK_TblAuditProviderRelations_TblExpert]
GO
ALTER TABLE [dbo].[TblAuditProviderRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditProviderRelations_TblProductCategory] FOREIGN KEY([ProductCatID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblAuditProviderRelations] CHECK CONSTRAINT [FK_TblAuditProviderRelations_TblProductCategory]
GO
ALTER TABLE [dbo].[TblAuditRealize]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealize_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditRealize] CHECK CONSTRAINT [FK_TblAuditRealize_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeDetail_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail] CHECK CONSTRAINT [FK_TblAuditRealizeDetail_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeDetail_TblLevelDetail] FOREIGN KEY([LevelID])
REFERENCES [dbo].[TblLevelDetail] ([LevelDetailID])
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail] CHECK CONSTRAINT [FK_TblAuditRealizeDetail_TblLevelDetail]
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeDetail_TblMajorGroup] FOREIGN KEY([MajorGroupID])
REFERENCES [dbo].[TblMajorGroup] ([MajorGroupID])
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail] CHECK CONSTRAINT [FK_TblAuditRealizeDetail_TblMajorGroup]
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeDetail_TblQuestion] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[TblQuestion] ([QuestionID])
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail] CHECK CONSTRAINT [FK_TblAuditRealizeDetail_TblQuestion]
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeDetail_TblRegulation] FOREIGN KEY([RegulationID])
REFERENCES [dbo].[TblRegulation] ([RegulationID])
GO
ALTER TABLE [dbo].[TblAuditRealizeDetail] CHECK CONSTRAINT [FK_TblAuditRealizeDetail_TblRegulation]
GO
ALTER TABLE [dbo].[TblAuditRealizeHistory]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeHistory_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblAuditRealizeHistory] CHECK CONSTRAINT [FK_TblAuditRealizeHistory_TblLocation]
GO
ALTER TABLE [dbo].[TblAuditRealizeHistory]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeHistory_TblTypeDetail] FOREIGN KEY([LocationTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblAuditRealizeHistory] CHECK CONSTRAINT [FK_TblAuditRealizeHistory_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblAuditRealizeHistory]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeHistory_TblVirtualRegion] FOREIGN KEY([VirtualRegionID])
REFERENCES [dbo].[TblVirtualRegion] ([VirtualRegionID])
GO
ALTER TABLE [dbo].[TblAuditRealizeHistory] CHECK CONSTRAINT [FK_TblAuditRealizeHistory_TblVirtualRegion]
GO
ALTER TABLE [dbo].[TblAuditRealizeImage]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeImage_TblAuditRealizeDetail] FOREIGN KEY([AuditReDetID])
REFERENCES [dbo].[TblAuditRealizeDetail] ([AudReDetID])
GO
ALTER TABLE [dbo].[TblAuditRealizeImage] CHECK CONSTRAINT [FK_TblAuditRealizeImage_TblAuditRealizeDetail]
GO
ALTER TABLE [dbo].[TblAuditRealizeMeasureResult]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeMeasureResult_TblAuditor] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblAuditRealizeMeasureResult] CHECK CONSTRAINT [FK_TblAuditRealizeMeasureResult_TblAuditor]
GO
ALTER TABLE [dbo].[TblAuditRealizeMeasureResult]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeMeasureResult_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditRealizeMeasureResult] CHECK CONSTRAINT [FK_TblAuditRealizeMeasureResult_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditRealizeMeasureResult]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeMeasureResult_TblMeasurement] FOREIGN KEY([MeasureID])
REFERENCES [dbo].[TblMeasurement] ([MeasurementID])
GO
ALTER TABLE [dbo].[TblAuditRealizeMeasureResult] CHECK CONSTRAINT [FK_TblAuditRealizeMeasureResult_TblMeasurement]
GO
ALTER TABLE [dbo].[TblAuditRealizeResponsible]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeResponsible_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblAuditRealizeResponsible] CHECK CONSTRAINT [FK_TblAuditRealizeResponsible_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblAuditRealizeResponsible]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditRealizeResponsible_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblAuditRealizeResponsible] CHECK CONSTRAINT [FK_TblAuditRealizeResponsible_TblEmployee]
GO
ALTER TABLE [dbo].[TblAuditTypeRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditTypeRelationship_TblAudit] FOREIGN KEY([AuditID])
REFERENCES [dbo].[TblAudit] ([AuditID])
GO
ALTER TABLE [dbo].[TblAuditTypeRelationship] CHECK CONSTRAINT [FK_TblAuditTypeRelationship_TblAudit]
GO
ALTER TABLE [dbo].[TblAuditTypeRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblAuditTypeRelationship_TblAuditType] FOREIGN KEY([AuditTypeID])
REFERENCES [dbo].[TblAuditType] ([AuditTypeID])
GO
ALTER TABLE [dbo].[TblAuditTypeRelationship] CHECK CONSTRAINT [FK_TblAuditTypeRelationship_TblAuditType]
GO
ALTER TABLE [dbo].[TblCalibrationDeviceDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCalibrationDeviceDetail_TblCalibrationDevice] FOREIGN KEY([DeviceID])
REFERENCES [dbo].[TblCalibrationDevice] ([CalibrationDeviceID])
GO
ALTER TABLE [dbo].[TblCalibrationDeviceDetail] CHECK CONSTRAINT [FK_TblCalibrationDeviceDetail_TblCalibrationDevice]
GO
ALTER TABLE [dbo].[TblCalibrationDeviceDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCalibrationDeviceDetail_TblEmployee] FOREIGN KEY([ReceiverEmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblCalibrationDeviceDetail] CHECK CONSTRAINT [FK_TblCalibrationDeviceDetail_TblEmployee]
GO
ALTER TABLE [dbo].[TblCalibrationDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblCalibrationDocument_TblCalibrationDevice] FOREIGN KEY([CalDeviceID])
REFERENCES [dbo].[TblCalibrationDevice] ([CalibrationDeviceID])
GO
ALTER TABLE [dbo].[TblCalibrationDocument] CHECK CONSTRAINT [FK_TblCalibrationDocument_TblCalibrationDevice]
GO
ALTER TABLE [dbo].[TblCalibrationDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblCalibrationDocument_TblCalibrationDeviceDetail] FOREIGN KEY([CalDeviceDetailID])
REFERENCES [dbo].[TblCalibrationDeviceDetail] ([CalibrationDeviceDetailID])
GO
ALTER TABLE [dbo].[TblCalibrationDocument] CHECK CONSTRAINT [FK_TblCalibrationDocument_TblCalibrationDeviceDetail]
GO
ALTER TABLE [dbo].[TblCalibrationInvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCalibrationInvoiceDetail_TblVirtualRegion] FOREIGN KEY([VirtualRegionId])
REFERENCES [dbo].[TblVirtualRegion] ([VirtualRegionID])
GO
ALTER TABLE [dbo].[TblCalibrationInvoiceDetail] CHECK CONSTRAINT [FK_TblCalibrationInvoiceDetail_TblVirtualRegion]
GO
ALTER TABLE [dbo].[TblCity]  WITH CHECK ADD  CONSTRAINT [FK_TblCity_TblRegion] FOREIGN KEY([RegionID])
REFERENCES [dbo].[TblRegion] ([RegionID])
GO
ALTER TABLE [dbo].[TblCity] CHECK CONSTRAINT [FK_TblCity_TblRegion]
GO
ALTER TABLE [dbo].[TblContact]  WITH CHECK ADD  CONSTRAINT [FK_TblContact_TblCity] FOREIGN KEY([CityID])
REFERENCES [dbo].[TblCity] ([CityID])
GO
ALTER TABLE [dbo].[TblContact] CHECK CONSTRAINT [FK_TblContact_TblCity]
GO
ALTER TABLE [dbo].[TblContact]  WITH CHECK ADD  CONSTRAINT [FK_TblContact_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblContact] CHECK CONSTRAINT [FK_TblContact_TblProvider]
GO
ALTER TABLE [dbo].[TblContact]  WITH CHECK ADD  CONSTRAINT [FK_TblContact_TblTowns] FOREIGN KEY([TownID])
REFERENCES [dbo].[TblTowns] ([TownId])
GO
ALTER TABLE [dbo].[TblContact] CHECK CONSTRAINT [FK_TblContact_TblTowns]
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCustomerOTLDetail_TblCustomerOTL] FOREIGN KEY([CustomerOTLID])
REFERENCES [dbo].[TblCustomerOTL] ([CustomerOTLID])
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail] CHECK CONSTRAINT [FK_TblCustomerOTLDetail_TblCustomerOTL]
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCustomerOTLDetail_TblCustomerOTLDetail] FOREIGN KEY([CustomerOTLDetailID])
REFERENCES [dbo].[TblCustomerOTLDetail] ([CustomerOTLDetailID])
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail] CHECK CONSTRAINT [FK_TblCustomerOTLDetail_TblCustomerOTLDetail]
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCustomerOTLDetail_TblProductCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail] CHECK CONSTRAINT [FK_TblCustomerOTLDetail_TblProductCategory]
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblCustomerOTLDetail_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblCustomerOTLDetail] CHECK CONSTRAINT [FK_TblCustomerOTLDetail_TblProvider]
GO
ALTER TABLE [dbo].[TblDBParameters]  WITH CHECK ADD  CONSTRAINT [FK__TblProvid__Param__75CD617E] FOREIGN KEY([ParameterTypeID])
REFERENCES [dbo].[TblDBParameterTypes] ([ParameterTypeID])
GO
ALTER TABLE [dbo].[TblDBParameters] CHECK CONSTRAINT [FK__TblProvid__Param__75CD617E]
GO
ALTER TABLE [dbo].[TblDepartment]  WITH CHECK ADD  CONSTRAINT [FK_TblDepartment_TblDepartment] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblDepartment] CHECK CONSTRAINT [FK_TblDepartment_TblDepartment]
GO
ALTER TABLE [dbo].[TblDepartmentRoleRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblDepartmentRoleRelationship_TblDepartment] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblDepartmentRoleRelationship] CHECK CONSTRAINT [FK_TblDepartmentRoleRelationship_TblDepartment]
GO
ALTER TABLE [dbo].[TblDepartmentRoleRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblDepartmentRoleRelationship_TblRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblDepartmentRoleRelationship] CHECK CONSTRAINT [FK_TblDepartmentRoleRelationship_TblRoles]
GO
ALTER TABLE [dbo].[TblDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblDocument_TblDocumentGroup] FOREIGN KEY([DocGroupID])
REFERENCES [dbo].[TblDocumentGroup] ([DocGroupID])
GO
ALTER TABLE [dbo].[TblDocument] CHECK CONSTRAINT [FK_TblDocument_TblDocumentGroup]
GO
ALTER TABLE [dbo].[TblDocumentAuthority]  WITH CHECK ADD  CONSTRAINT [FK_TblDocumentAuthority_TblProcedureDocument] FOREIGN KEY([ProcedureDocumentID])
REFERENCES [dbo].[TblProcedureDocument] ([ProcedureDocumentID])
GO
ALTER TABLE [dbo].[TblDocumentAuthority] CHECK CONSTRAINT [FK_TblDocumentAuthority_TblProcedureDocument]
GO
ALTER TABLE [dbo].[TblDocumentAuthority]  WITH CHECK ADD  CONSTRAINT [FK_TblDocumentAuthority_TblTypeDetail] FOREIGN KEY([LocationTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblDocumentAuthority] CHECK CONSTRAINT [FK_TblDocumentAuthority_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblEmergency]  WITH CHECK ADD  CONSTRAINT [FK_TblEmergency_TblOHSEquipment_Activity] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[TblOHSEquipment_Activity] ([IncKeyNo])
GO
ALTER TABLE [dbo].[TblEmergency] CHECK CONSTRAINT [FK_TblEmergency_TblOHSEquipment_Activity]
GO
ALTER TABLE [dbo].[TblEmergency]  WITH CHECK ADD  CONSTRAINT [FK_TblEmergency_TblTypeDetail] FOREIGN KEY([TypeId])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblEmergency] CHECK CONSTRAINT [FK_TblEmergency_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblEmergencyAction]  WITH CHECK ADD  CONSTRAINT [FK_TblEmergencyAction_TblDepartment] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblEmergencyAction] CHECK CONSTRAINT [FK_TblEmergencyAction_TblDepartment]
GO
ALTER TABLE [dbo].[TblEmergencyAction]  WITH CHECK ADD  CONSTRAINT [FK_TblEmergencyAction_TblEmergency] FOREIGN KEY([EmergencyId])
REFERENCES [dbo].[TblEmergency] ([EmergencyId])
GO
ALTER TABLE [dbo].[TblEmergencyAction] CHECK CONSTRAINT [FK_TblEmergencyAction_TblEmergency]
GO
ALTER TABLE [dbo].[TblEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployee_TblCertificate] FOREIGN KEY([CertificateID])
REFERENCES [dbo].[TblCertificate] ([CertificateID])
GO
ALTER TABLE [dbo].[TblEmployee] CHECK CONSTRAINT [FK_TblEmployee_TblCertificate]
GO
ALTER TABLE [dbo].[TblEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployee_TblContact] FOREIGN KEY([ContactID])
REFERENCES [dbo].[TblContact] ([ContactID])
GO
ALTER TABLE [dbo].[TblEmployee] CHECK CONSTRAINT [FK_TblEmployee_TblContact]
GO
ALTER TABLE [dbo].[TblEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployee_TblDepartment] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblEmployee] CHECK CONSTRAINT [FK_TblEmployee_TblDepartment]
GO
ALTER TABLE [dbo].[TblEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployee_TblRoles] FOREIGN KEY([PositionRoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblEmployee] CHECK CONSTRAINT [FK_TblEmployee_TblRoles]
GO
ALTER TABLE [dbo].[TblEmployeeCertificate]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeCertificate_TblCertificate] FOREIGN KEY([CertificateID])
REFERENCES [dbo].[TblCertificate] ([CertificateID])
GO
ALTER TABLE [dbo].[TblEmployeeCertificate] CHECK CONSTRAINT [FK_TblEmployeeCertificate_TblCertificate]
GO
ALTER TABLE [dbo].[TblEmployeeCertificate]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeCertificate_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblEmployeeCertificate] CHECK CONSTRAINT [FK_TblEmployeeCertificate_TblDocument]
GO
ALTER TABLE [dbo].[TblEmployeeCertificate]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeCertificate_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblEmployeeCertificate] CHECK CONSTRAINT [FK_TblEmployeeCertificate_TblEmployee]
GO
ALTER TABLE [dbo].[TblEmployeeLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeLocation_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblEmployeeLocation] CHECK CONSTRAINT [FK_TblEmployeeLocation_TblEmployee]
GO
ALTER TABLE [dbo].[TblEmployeeLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeLocation_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblEmployeeLocation] CHECK CONSTRAINT [FK_TblEmployeeLocation_TblLocation]
GO
ALTER TABLE [dbo].[TblEmployeeMeasDevice]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeMeasDevice_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblEmployeeMeasDevice] CHECK CONSTRAINT [FK_TblEmployeeMeasDevice_TblEmployee]
GO
ALTER TABLE [dbo].[TblEmployeeMeasDevice]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeMeasDevice_TblMeasDevice] FOREIGN KEY([MeasDeviceID])
REFERENCES [dbo].[TblMeasDevice] ([MeasDeviceID])
GO
ALTER TABLE [dbo].[TblEmployeeMeasDevice] CHECK CONSTRAINT [FK_TblEmployeeMeasDevice_TblMeasDevice]
GO
ALTER TABLE [dbo].[TblEmployeeProvider]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeProvider_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblEmployeeProvider] CHECK CONSTRAINT [FK_TblEmployeeProvider_TblEmployee]
GO
ALTER TABLE [dbo].[TblEmployeeProvider]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeProvider_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblEmployeeProvider] CHECK CONSTRAINT [FK_TblEmployeeProvider_TblProvider]
GO
ALTER TABLE [dbo].[TblEmployeeRoles]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeRoles_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblEmployeeRoles] CHECK CONSTRAINT [FK_TblEmployeeRoles_TblEmployee]
GO
ALTER TABLE [dbo].[TblEmployeeRoles]  WITH CHECK ADD  CONSTRAINT [FK_TblEmployeeRoles_TblRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblEmployeeRoles] CHECK CONSTRAINT [FK_TblEmployeeRoles_TblRoles]
GO
ALTER TABLE [dbo].[TblEvidence]  WITH CHECK ADD  CONSTRAINT [FK_TblEvidence_TblAuditRealizeDetail] FOREIGN KEY([AudReDetID])
REFERENCES [dbo].[TblAuditRealizeDetail] ([AudReDetID])
GO
ALTER TABLE [dbo].[TblEvidence] CHECK CONSTRAINT [FK_TblEvidence_TblAuditRealizeDetail]
GO
ALTER TABLE [dbo].[TblEvidence]  WITH CHECK ADD  CONSTRAINT [FK_TblEvidence_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblEvidence] CHECK CONSTRAINT [FK_TblEvidence_TblDocument]
GO
ALTER TABLE [dbo].[TblEvidence]  WITH CHECK ADD  CONSTRAINT [FK_TblEvidence_TblLevel1] FOREIGN KEY([EvidenceLevelId])
REFERENCES [dbo].[TblLevel] ([EvidenceLevelId])
GO
ALTER TABLE [dbo].[TblEvidence] CHECK CONSTRAINT [FK_TblEvidence_TblLevel1]
GO
ALTER TABLE [dbo].[TblEvidenceFromAudit]  WITH CHECK ADD  CONSTRAINT [FK_TblEvidenceFromAudit_TblEvidence] FOREIGN KEY([EvidenceID])
REFERENCES [dbo].[TblEvidence] ([EvidenceID])
GO
ALTER TABLE [dbo].[TblEvidenceFromAudit] CHECK CONSTRAINT [FK_TblEvidenceFromAudit_TblEvidence]
GO
ALTER TABLE [dbo].[TblExpertDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblExpertDetail_TblCertificate] FOREIGN KEY([CertificateID])
REFERENCES [dbo].[TblCertificate] ([CertificateID])
GO
ALTER TABLE [dbo].[TblExpertDetail] CHECK CONSTRAINT [FK_TblExpertDetail_TblCertificate]
GO
ALTER TABLE [dbo].[TblExpertDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblExpertDetail_TblExpert] FOREIGN KEY([ExpertID])
REFERENCES [dbo].[TblExpert] ([ExpertID])
GO
ALTER TABLE [dbo].[TblExpertDetail] CHECK CONSTRAINT [FK_TblExpertDetail_TblExpert]
GO
ALTER TABLE [dbo].[TblFixedActivity]  WITH CHECK ADD  CONSTRAINT [FK_TblFixedActivity_TblAuditRealizeDetail] FOREIGN KEY([AuditReDetID])
REFERENCES [dbo].[TblAuditRealizeDetail] ([AudReDetID])
GO
ALTER TABLE [dbo].[TblFixedActivity] CHECK CONSTRAINT [FK_TblFixedActivity_TblAuditRealizeDetail]
GO
ALTER TABLE [dbo].[TblFixedActivity]  WITH CHECK ADD  CONSTRAINT [FK_TblFixedActivity_TblEmployee] FOREIGN KEY([PlanEmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblFixedActivity] CHECK CONSTRAINT [FK_TblFixedActivity_TblEmployee]
GO
ALTER TABLE [dbo].[TblFormAuthority]  WITH CHECK ADD  CONSTRAINT [FK_TblFormAuthority_TblFormMain] FOREIGN KEY([FormID])
REFERENCES [dbo].[TblFormMain] ([FormID])
GO
ALTER TABLE [dbo].[TblFormAuthority] CHECK CONSTRAINT [FK_TblFormAuthority_TblFormMain]
GO
ALTER TABLE [dbo].[TblFormAuthority]  WITH CHECK ADD  CONSTRAINT [FK_TblFormAuthority_TblRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblFormAuthority] CHECK CONSTRAINT [FK_TblFormAuthority_TblRoles]
GO
ALTER TABLE [dbo].[TblFormAuthorityRole]  WITH CHECK ADD  CONSTRAINT [FK_TblFormAuthorityRole_TblFormAuthority] FOREIGN KEY([FormAuthorityID])
REFERENCES [dbo].[TblFormAuthority] ([FormAuthorityID])
GO
ALTER TABLE [dbo].[TblFormAuthorityRole] CHECK CONSTRAINT [FK_TblFormAuthorityRole_TblFormAuthority]
GO
ALTER TABLE [dbo].[TblFormAuthorityRole]  WITH CHECK ADD  CONSTRAINT [FK_TblFormAuthorityRole_TblRoles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblFormAuthorityRole] CHECK CONSTRAINT [FK_TblFormAuthorityRole_TblRoles]
GO
ALTER TABLE [dbo].[TblFormDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblFormDetail_TblFormFieldType] FOREIGN KEY([FormFieldTypeID])
REFERENCES [dbo].[TblFormFieldType] ([FormFieldTypeID])
GO
ALTER TABLE [dbo].[TblFormDetail] CHECK CONSTRAINT [FK_TblFormDetail_TblFormFieldType]
GO
ALTER TABLE [dbo].[TblFormDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblFormDetail_TblFormMain] FOREIGN KEY([FormId])
REFERENCES [dbo].[TblFormMain] ([FormID])
GO
ALTER TABLE [dbo].[TblFormDetail] CHECK CONSTRAINT [FK_TblFormDetail_TblFormMain]
GO
ALTER TABLE [dbo].[TblFormDetailFill]  WITH CHECK ADD  CONSTRAINT [FK_TblFormDetailFill_TblFormDetail] FOREIGN KEY([FieldId])
REFERENCES [dbo].[TblFormDetail] ([FormDetailId])
GO
ALTER TABLE [dbo].[TblFormDetailFill] CHECK CONSTRAINT [FK_TblFormDetailFill_TblFormDetail]
GO
ALTER TABLE [dbo].[TblFormDetailFill]  WITH CHECK ADD  CONSTRAINT [FK_TblFormDetailFill_TblFormMainFill] FOREIGN KEY([FormFillID])
REFERENCES [dbo].[TblFormMainFill] ([FormFillId])
GO
ALTER TABLE [dbo].[TblFormDetailFill] CHECK CONSTRAINT [FK_TblFormDetailFill_TblFormMainFill]
GO
ALTER TABLE [dbo].[TblFormMain]  WITH CHECK ADD  CONSTRAINT [FK_TblFormMain_TblEmployee] FOREIGN KEY([FormIdentifyEmpID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblFormMain] CHECK CONSTRAINT [FK_TblFormMain_TblEmployee]
GO
ALTER TABLE [dbo].[TblFormMain]  WITH CHECK ADD  CONSTRAINT [FK_TblFormMain_TblRegulation] FOREIGN KEY([RegulationId])
REFERENCES [dbo].[TblRegulation] ([RegulationID])
GO
ALTER TABLE [dbo].[TblFormMain] CHECK CONSTRAINT [FK_TblFormMain_TblRegulation]
GO
ALTER TABLE [dbo].[TblFormMainFill]  WITH CHECK ADD  CONSTRAINT [FK_TblFormMainFill_TblEmployee] FOREIGN KEY([FilledEmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblFormMainFill] CHECK CONSTRAINT [FK_TblFormMainFill_TblEmployee]
GO
ALTER TABLE [dbo].[TblFormMainFill]  WITH CHECK ADD  CONSTRAINT [FK_TblFormMainFill_TblFormMain] FOREIGN KEY([FormId])
REFERENCES [dbo].[TblFormMain] ([FormID])
GO
ALTER TABLE [dbo].[TblFormMainFill] CHECK CONSTRAINT [FK_TblFormMainFill_TblFormMain]
GO
ALTER TABLE [dbo].[TblFormRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblFormRelations_TblDepartment] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblFormRelations] CHECK CONSTRAINT [FK_TblFormRelations_TblDepartment]
GO
ALTER TABLE [dbo].[TblFormRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblFormRelations_TblFormMain] FOREIGN KEY([FormId])
REFERENCES [dbo].[TblFormMain] ([FormID])
GO
ALTER TABLE [dbo].[TblFormRelations] CHECK CONSTRAINT [FK_TblFormRelations_TblFormMain]
GO
ALTER TABLE [dbo].[TblGroup]  WITH CHECK ADD  CONSTRAINT [FK_TblGroup_TblPeriod] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[TblPeriod] ([PeriodID])
GO
ALTER TABLE [dbo].[TblGroup] CHECK CONSTRAINT [FK_TblGroup_TblPeriod]
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblGroup] FOREIGN KEY([GroupID])
REFERENCES [dbo].[TblGroup] ([GroupID])
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment] CHECK CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblGroup]
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblGroup1] FOREIGN KEY([GroupID])
REFERENCES [dbo].[TblGroup] ([GroupID])
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment] CHECK CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblGroup1]
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblTypeDetail] FOREIGN KEY([TypeDetailID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment] CHECK CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblTypeDetail1] FOREIGN KEY([TypeDetailID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblGroupLocationTypeAssignment] CHECK CONSTRAINT [FK_TblGroupLocationTypeAssignment_TblTypeDetail1]
GO
ALTER TABLE [dbo].[TblHandAndDeviceCorrective]  WITH CHECK ADD  CONSTRAINT [FK_TblHandAndDeviceCorrective_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblHandAndDeviceCorrective] CHECK CONSTRAINT [FK_TblHandAndDeviceCorrective_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblLabOperationRequest]  WITH CHECK ADD  CONSTRAINT [FK_TblLabOperationRequest_TblEmployee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblLabOperationRequest] CHECK CONSTRAINT [FK_TblLabOperationRequest_TblEmployee]
GO
ALTER TABLE [dbo].[TblLabOperationRequest]  WITH CHECK ADD  CONSTRAINT [FK_TblLabOperationRequest_TblLabNumunePeriyot] FOREIGN KEY([LabNumunePeriyotId])
REFERENCES [dbo].[TblLabNumunePeriyot] ([LabNumunePeriyotId])
GO
ALTER TABLE [dbo].[TblLabOperationRequest] CHECK CONSTRAINT [FK_TblLabOperationRequest_TblLabNumunePeriyot]
GO
ALTER TABLE [dbo].[TblLabOperationRequest]  WITH CHECK ADD  CONSTRAINT [FK_TblLabOperationRequest_TblLocation] FOREIGN KEY([LocationId])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblLabOperationRequest] CHECK CONSTRAINT [FK_TblLabOperationRequest_TblLocation]
GO
ALTER TABLE [dbo].[TblLaboratoryRequest]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequest_TblEmployee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblLaboratoryRequest] CHECK CONSTRAINT [FK_TblLaboratoryRequest_TblEmployee]
GO
ALTER TABLE [dbo].[TblLaboratoryRequest]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequest_TblLabNumunePeriyot] FOREIGN KEY([LabPeriyotId])
REFERENCES [dbo].[TblLabNumunePeriyot] ([LabNumunePeriyotId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequest] CHECK CONSTRAINT [FK_TblLaboratoryRequest_TblLabNumunePeriyot]
GO
ALTER TABLE [dbo].[TblLaboratoryRequest]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequest_TblLocation] FOREIGN KEY([LocationId])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblLaboratoryRequest] CHECK CONSTRAINT [FK_TblLaboratoryRequest_TblLocation]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLine_TblLabNumuneAlimSebebi] FOREIGN KEY([LabNumuneAlimSebebiId])
REFERENCES [dbo].[TblLabNumuneAlimSebebi] ([LabNumuneAlimSebebiId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestLine_TblLabNumuneAlimSebebi]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLine_TblLabNumuneDurum] FOREIGN KEY([LabNumuneDurumId])
REFERENCES [dbo].[TblLabNumuneDurum] ([LabNumuneDurumId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestLine_TblLabNumuneDurum]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLine_TblLabNumuneTipi] FOREIGN KEY([LabNumuneTipiId])
REFERENCES [dbo].[TblLabNumuneTipi] ([LabNumuneTipiId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestLine_TblLabNumuneTipi]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLine_TblLaboratoryRequest] FOREIGN KEY([LaboratoryRequestId])
REFERENCES [dbo].[TblLaboratoryRequest] ([LaboratoryRequestId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestLine_TblLaboratoryRequest]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLine_TblProvider] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestLine_TblProvider]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLineDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLineDetail_TblLaboratoryRequestLine] FOREIGN KEY([LaboratoryRequestLineId])
REFERENCES [dbo].[TblLaboratoryRequestLine] ([LaboratoryRequestLineId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLineDetail] CHECK CONSTRAINT [FK_TblLaboratoryRequestLineDetail_TblLaboratoryRequestLine]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLineDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestLineDetail_TblProvideSampleParametersMatchs] FOREIGN KEY([PSPMatchId])
REFERENCES [dbo].[TblProvideSampleParametersMatchs] ([PSpMatchId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestLineDetail] CHECK CONSTRAINT [FK_TblLaboratoryRequestLineDetail_TblProvideSampleParametersMatchs]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblLabNumuneAlimSebebi] FOREIGN KEY([LabNumuneAlimSebebiId])
REFERENCES [dbo].[TblLabNumuneAlimSebebi] ([LabNumuneAlimSebebiId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblLabNumuneAlimSebebi]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblLaboratoryRequestPlan] FOREIGN KEY([LabRequestPlanId])
REFERENCES [dbo].[TblLaboratoryRequestPlan] ([LabRequestPlanId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblLaboratoryRequestPlan]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblLocation] FOREIGN KEY([LocationId])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblLocation]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblProvider] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLine] CHECK CONSTRAINT [FK_TblLaboratoryRequestPlanLine_TblProvider]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLineDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestPlanLineDetail_TblLaboratoryRequestPlanLine] FOREIGN KEY([LabRequestPlanLineId])
REFERENCES [dbo].[TblLaboratoryRequestPlanLine] ([LabRequestPlanLineId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLineDetail] CHECK CONSTRAINT [FK_TblLaboratoryRequestPlanLineDetail_TblLaboratoryRequestPlanLine]
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLineDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblLaboratoryRequestPlanLineDetail_TblProvideSampleParametersMatchs] FOREIGN KEY([PSPMatchId])
REFERENCES [dbo].[TblProvideSampleParametersMatchs] ([PSpMatchId])
GO
ALTER TABLE [dbo].[TblLaboratoryRequestPlanLineDetail] CHECK CONSTRAINT [FK_TblLaboratoryRequestPlanLineDetail_TblProvideSampleParametersMatchs]
GO
ALTER TABLE [dbo].[TblLabRequestAnalyseResultFiles]  WITH CHECK ADD  CONSTRAINT [FK_TblLabRequestAnalyseResultFiles_TblLaboratoryRequest] FOREIGN KEY([LabRequest])
REFERENCES [dbo].[TblLaboratoryRequest] ([LaboratoryRequestId])
GO
ALTER TABLE [dbo].[TblLabRequestAnalyseResultFiles] CHECK CONSTRAINT [FK_TblLabRequestAnalyseResultFiles_TblLaboratoryRequest]
GO
ALTER TABLE [dbo].[TblLevelDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblLevelDetail_TblLevel] FOREIGN KEY([LevelID])
REFERENCES [dbo].[TblLevel] ([EvidenceLevelId])
GO
ALTER TABLE [dbo].[TblLevelDetail] CHECK CONSTRAINT [FK_TblLevelDetail_TblLevel]
GO
ALTER TABLE [dbo].[TblLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblLocation_TblContact] FOREIGN KEY([ContactID])
REFERENCES [dbo].[TblContact] ([ContactID])
GO
ALTER TABLE [dbo].[TblLocation] CHECK CONSTRAINT [FK_TblLocation_TblContact]
GO
ALTER TABLE [dbo].[TblLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblLocation_TblTypeDetail] FOREIGN KEY([LocationTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblLocation] CHECK CONSTRAINT [FK_TblLocation_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblLocation_TblVirtualRegion] FOREIGN KEY([RegionID])
REFERENCES [dbo].[TblVirtualRegion] ([VirtualRegionID])
GO
ALTER TABLE [dbo].[TblLocation] CHECK CONSTRAINT [FK_TblLocation_TblVirtualRegion]
GO
ALTER TABLE [dbo].[TblLocationAuditor]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationAuditor_TblAuditor1] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblLocationAuditor] CHECK CONSTRAINT [FK_TblLocationAuditor_TblAuditor1]
GO
ALTER TABLE [dbo].[TblLocationAuditor]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationAuditor_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblLocationAuditor] CHECK CONSTRAINT [FK_TblLocationAuditor_TblLocation]
GO
ALTER TABLE [dbo].[TblLocationDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationDocument_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblLocationDocument] CHECK CONSTRAINT [FK_TblLocationDocument_TblDocument]
GO
ALTER TABLE [dbo].[TblLocationDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationDocument_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblLocationDocument] CHECK CONSTRAINT [FK_TblLocationDocument_TblLocation]
GO
ALTER TABLE [dbo].[TblLocationRegion]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationRegion_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblLocationRegion] CHECK CONSTRAINT [FK_TblLocationRegion_TblLocation]
GO
ALTER TABLE [dbo].[TblLocationRegion]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationRegion_TblRegion] FOREIGN KEY([RegionID])
REFERENCES [dbo].[TblRegion] ([RegionID])
GO
ALTER TABLE [dbo].[TblLocationRegion] CHECK CONSTRAINT [FK_TblLocationRegion_TblRegion]
GO
ALTER TABLE [dbo].[TblLocationTypeAuditArea]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeAuditArea_TblAuditArea] FOREIGN KEY([AuditScopeID])
REFERENCES [dbo].[TblAuditArea] ([AuditScopeID])
GO
ALTER TABLE [dbo].[TblLocationTypeAuditArea] CHECK CONSTRAINT [FK_TblLocationTypeAuditArea_TblAuditArea]
GO
ALTER TABLE [dbo].[TblLocationTypeAuditArea]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeAuditArea_TblTypeDetail] FOREIGN KEY([TypeDetailId])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblLocationTypeAuditArea] CHECK CONSTRAINT [FK_TblLocationTypeAuditArea_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblLocationTypeAuditorAttendRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeAuditorAttendRelationship_TblAuditor] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblLocationTypeAuditorAttendRelationship] CHECK CONSTRAINT [FK_TblLocationTypeAuditorAttendRelationship_TblAuditor]
GO
ALTER TABLE [dbo].[TblLocationTypeAuditorAttendRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeAuditorAttendRelationship_TblLocationAuditorAttend] FOREIGN KEY([LocationTypeAuditorAttendID])
REFERENCES [dbo].[TblLocationAuditorAttend] ([InckeyNo])
GO
ALTER TABLE [dbo].[TblLocationTypeAuditorAttendRelationship] CHECK CONSTRAINT [FK_TblLocationTypeAuditorAttendRelationship_TblLocationAuditorAttend]
GO
ALTER TABLE [dbo].[TblLocationTypeMeasurePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeMeasurePlan_TblMeasurement] FOREIGN KEY([MeasurementID])
REFERENCES [dbo].[TblMeasurement] ([MeasurementID])
GO
ALTER TABLE [dbo].[TblLocationTypeMeasurePlan] CHECK CONSTRAINT [FK_TblLocationTypeMeasurePlan_TblMeasurement]
GO
ALTER TABLE [dbo].[TblLocationTypeMeasurePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeMeasurePlan_TblTypeDetail] FOREIGN KEY([TypeDetailId])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblLocationTypeMeasurePlan] CHECK CONSTRAINT [FK_TblLocationTypeMeasurePlan_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblLocationTypeQuestionCatEffect]  WITH CHECK ADD  CONSTRAINT [FK_TblLocationTypeQuestionCatEffect_TblTypeDetail] FOREIGN KEY([LocTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblLocationTypeQuestionCatEffect] CHECK CONSTRAINT [FK_TblLocationTypeQuestionCatEffect_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblMasterRegulation]  WITH CHECK ADD  CONSTRAINT [FK_TblMasterRegulation_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblMasterRegulation] CHECK CONSTRAINT [FK_TblMasterRegulation_TblEmployee]
GO
ALTER TABLE [dbo].[TblMasterRegulationDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMasterRegulationDetail_TblMasterRegulation] FOREIGN KEY([MasterRegulationID])
REFERENCES [dbo].[TblMasterRegulation] ([MasterRegulationD])
GO
ALTER TABLE [dbo].[TblMasterRegulationDetail] CHECK CONSTRAINT [FK_TblMasterRegulationDetail_TblMasterRegulation]
GO
ALTER TABLE [dbo].[TblMaterialServiceAccreditation]  WITH CHECK ADD  CONSTRAINT [FK_TblMaterialServiceAccreditation_TblAccSet] FOREIGN KEY([AccSetID])
REFERENCES [dbo].[TblAccSet] ([AccSetID])
GO
ALTER TABLE [dbo].[TblMaterialServiceAccreditation] CHECK CONSTRAINT [FK_TblMaterialServiceAccreditation_TblAccSet]
GO
ALTER TABLE [dbo].[TblMaterialServiceAccreditation]  WITH CHECK ADD  CONSTRAINT [FK_TblMaterialServiceAccreditation_TblMaterialServices] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[TblMaterialServices] ([MaterialID])
GO
ALTER TABLE [dbo].[TblMaterialServiceAccreditation] CHECK CONSTRAINT [FK_TblMaterialServiceAccreditation_TblMaterialServices]
GO
ALTER TABLE [dbo].[TblMaterialServiceAccreditation]  WITH CHECK ADD  CONSTRAINT [FK_TblMaterialServiceAccreditation_TblTypeDetail] FOREIGN KEY([LocationType])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblMaterialServiceAccreditation] CHECK CONSTRAINT [FK_TblMaterialServiceAccreditation_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblMaterialServices]  WITH CHECK ADD  CONSTRAINT [FK_TblMaterialServices_TblProductCategory] FOREIGN KEY([CatID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblMaterialServices] CHECK CONSTRAINT [FK_TblMaterialServices_TblProductCategory]
GO
ALTER TABLE [dbo].[TblMaterialServices]  WITH CHECK ADD  CONSTRAINT [FK_TblMaterialServices_TblUnitType] FOREIGN KEY([UnitID])
REFERENCES [dbo].[TblUnitType] ([UnitID])
GO
ALTER TABLE [dbo].[TblMaterialServices] CHECK CONSTRAINT [FK_TblMaterialServices_TblUnitType]
GO
ALTER TABLE [dbo].[TblMeasurement]  WITH CHECK ADD  CONSTRAINT [FK_TblMeasurement_TblMeasDevice] FOREIGN KEY([MeasDeviceID])
REFERENCES [dbo].[TblMeasDevice] ([MeasDeviceID])
GO
ALTER TABLE [dbo].[TblMeasurement] CHECK CONSTRAINT [FK_TblMeasurement_TblMeasDevice]
GO
ALTER TABLE [dbo].[TblMessage]  WITH CHECK ADD  CONSTRAINT [FK_TblMessage_TblMessageType] FOREIGN KEY([MessageTypeID])
REFERENCES [dbo].[TblMessageType] ([MessageTypeID])
GO
ALTER TABLE [dbo].[TblMessage] CHECK CONSTRAINT [FK_TblMessage_TblMessageType]
GO
ALTER TABLE [dbo].[TblMessage]  WITH CHECK ADD  CONSTRAINT [FK_TblMessage_TblUser] FOREIGN KEY([SenderUserID])
REFERENCES [dbo].[TblUser] ([UserID])
GO
ALTER TABLE [dbo].[TblMessage] CHECK CONSTRAINT [FK_TblMessage_TblUser]
GO
ALTER TABLE [dbo].[TblMessageDepartmentAuth]  WITH CHECK ADD  CONSTRAINT [FK_TblMessageDeparmentAuth_TblRoles] FOREIGN KEY([SendeRoleID])
REFERENCES [dbo].[TblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TblMessageDepartmentAuth] CHECK CONSTRAINT [FK_TblMessageDeparmentAuth_TblRoles]
GO
ALTER TABLE [dbo].[TblMessageDepartmentAuth]  WITH CHECK ADD  CONSTRAINT [FK_TblMessageDepartmentAuth_TblDepartment] FOREIGN KEY([ReceiverDepartmentID])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblMessageDepartmentAuth] CHECK CONSTRAINT [FK_TblMessageDepartmentAuth_TblDepartment]
GO
ALTER TABLE [dbo].[TblMessageTemplate]  WITH CHECK ADD  CONSTRAINT [FK_TblMessageTemplate_TblMessageType] FOREIGN KEY([MessageTypeID])
REFERENCES [dbo].[TblMessageType] ([MessageTypeID])
GO
ALTER TABLE [dbo].[TblMessageTemplate] CHECK CONSTRAINT [FK_TblMessageTemplate_TblMessageType]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblAuditor] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblAuditor]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblAuditPlan] FOREIGN KEY([AuditPlanID])
REFERENCES [dbo].[TblAuditPlan] ([AuditPlanID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblAuditPlan]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblAuditRealizeDetail] FOREIGN KEY([AudReDetID])
REFERENCES [dbo].[TblAuditRealizeDetail] ([AudReDetID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblAuditRealizeDetail]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblDistorted] FOREIGN KEY([DistortedID])
REFERENCES [dbo].[TblDistorted] ([DistortedID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblDistorted]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblProcess] FOREIGN KEY([ProcessID])
REFERENCES [dbo].[TblProcess] ([ProcessID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblProcess]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblProductCategory] FOREIGN KEY([ProductTypeID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblProductCategory]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblUnitType] FOREIGN KEY([UnitID])
REFERENCES [dbo].[TblUnitType] ([UnitID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblUnitType]
GO
ALTER TABLE [dbo].[TblMinutesDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblMinutesDetail_TblUnsuitabilitySource1] FOREIGN KEY([UnsuitabilitySourceID])
REFERENCES [dbo].[TblUnsuitabilitySource] ([UnsuitabilitySourceID])
GO
ALTER TABLE [dbo].[TblMinutesDetail] CHECK CONSTRAINT [FK_TblMinutesDetail_TblUnsuitabilitySource1]
GO
ALTER TABLE [dbo].[TblMonitoringAndMeasurementPeriod]  WITH CHECK ADD  CONSTRAINT [FK_TblMonitoringAndMeasurementPeriod_TblOHSMonitoringAndMeasurement] FOREIGN KEY([MonitoringAndMeasurementID])
REFERENCES [dbo].[TblOHSMonitoringAndMeasurement] ([MonitoringAndMeasurementID])
GO
ALTER TABLE [dbo].[TblMonitoringAndMeasurementPeriod] CHECK CONSTRAINT [FK_TblMonitoringAndMeasurementPeriod_TblOHSMonitoringAndMeasurement]
GO
ALTER TABLE [dbo].[TblOHSAdditionalPreventionRiskAssessRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSAdditionalPreventionRiskAssessRelations_TblOHSControlPrevention] FOREIGN KEY([ControlPreventionID])
REFERENCES [dbo].[TblOHSControlPrevention] ([ControlPreventionID])
GO
ALTER TABLE [dbo].[TblOHSAdditionalPreventionRiskAssessRelations] CHECK CONSTRAINT [FK_TblOHSAdditionalPreventionRiskAssessRelations_TblOHSControlPrevention]
GO
ALTER TABLE [dbo].[TblOHSAdditionalPreventionRiskAssessRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSAdditionalPreventionRiskAssessRelations_TblOHSRiskAssessmentTable] FOREIGN KEY([RiskAssessmentID])
REFERENCES [dbo].[TblOHSRiskAssessmentTable] ([RiskAssessmentID])
GO
ALTER TABLE [dbo].[TblOHSAdditionalPreventionRiskAssessRelations] CHECK CONSTRAINT [FK_TblOHSAdditionalPreventionRiskAssessRelations_TblOHSRiskAssessmentTable]
GO
ALTER TABLE [dbo].[TblOHSDangerStatus]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSDangerStatus_TblOHSDangerSource] FOREIGN KEY([OHSRiskSourceID])
REFERENCES [dbo].[TblOHSDangerSource] ([DangerSourceID])
GO
ALTER TABLE [dbo].[TblOHSDangerStatus] CHECK CONSTRAINT [FK_TblOHSDangerStatus_TblOHSDangerSource]
GO
ALTER TABLE [dbo].[TblOHSEmergencyRootCause]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSEmergencyRootCause_TblEmergency] FOREIGN KEY([EmergencyID])
REFERENCES [dbo].[TblEmergency] ([EmergencyId])
GO
ALTER TABLE [dbo].[TblOHSEmergencyRootCause] CHECK CONSTRAINT [FK_TblOHSEmergencyRootCause_TblEmergency]
GO
ALTER TABLE [dbo].[TblOHSEmergencyRootCause]  WITH NOCHECK ADD  CONSTRAINT [FK_TblOHSEmergencyRootCause_TblOHSEmergencyRootCause] FOREIGN KEY([EmergencyRootCauseID])
REFERENCES [dbo].[TblOHSEmergencyRootCause] ([EmergencyRootCauseID])
GO
ALTER TABLE [dbo].[TblOHSEmergencyRootCause] CHECK CONSTRAINT [FK_TblOHSEmergencyRootCause_TblOHSEmergencyRootCause]
GO
ALTER TABLE [dbo].[TblOHSEmergencyRootCause]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSEmergencyRootCause_TblOHSRemakWorkAccRootCause] FOREIGN KEY([RootCauseID])
REFERENCES [dbo].[TblOHSRemakWorkAccRootCause] ([RootCauseID])
GO
ALTER TABLE [dbo].[TblOHSEmergencyRootCause] CHECK CONSTRAINT [FK_TblOHSEmergencyRootCause_TblOHSRemakWorkAccRootCause]
GO
ALTER TABLE [dbo].[TblOHSEmployeeRepresentativeEmpRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSEmployeeRepresentativeEmpRelations_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSEmployeeRepresentativeEmpRelations] CHECK CONSTRAINT [FK_TblOHSEmployeeRepresentativeEmpRelations_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSEmployeeRepresentativeEmpRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSEmployeeRepresentativeEmpRelations_TblOHSRiskEssesmentTableLocation] FOREIGN KEY([RiskAssessmentLocID])
REFERENCES [dbo].[TblOHSRiskEssesmentTableLocation] ([RiskAssessmentLocID])
GO
ALTER TABLE [dbo].[TblOHSEmployeeRepresentativeEmpRelations] CHECK CONSTRAINT [FK_TblOHSEmployeeRepresentativeEmpRelations_TblOHSRiskEssesmentTableLocation]
GO
ALTER TABLE [dbo].[TblOHSMeasurementResponsible]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSMeasurementResponsible_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSMeasurementResponsible] CHECK CONSTRAINT [FK_TblOHSMeasurementResponsible_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSMeasurementResponsible]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSMeasurementResponsible_TblOHSMonitoringAndMeasurement] FOREIGN KEY([MonitoringAndMeasurementID])
REFERENCES [dbo].[TblOHSMonitoringAndMeasurement] ([MonitoringAndMeasurementID])
GO
ALTER TABLE [dbo].[TblOHSMeasurementResponsible] CHECK CONSTRAINT [FK_TblOHSMeasurementResponsible_TblOHSMonitoringAndMeasurement]
GO
ALTER TABLE [dbo].[TblOHSMonitoringAndMeasurement]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSMonitoringAndMeasurement_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblOHSMonitoringAndMeasurement] CHECK CONSTRAINT [FK_TblOHSMonitoringAndMeasurement_TblLocation]
GO
ALTER TABLE [dbo].[TblOHSMonitoringAndMeasurement]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSMonitoringAndMeasurement_TblOHSEquipment_Activity] FOREIGN KEY([IncKeyNo])
REFERENCES [dbo].[TblOHSEquipment_Activity] ([IncKeyNo])
GO
ALTER TABLE [dbo].[TblOHSMonitoringAndMeasurement] CHECK CONSTRAINT [FK_TblOHSMonitoringAndMeasurement_TblOHSEquipment_Activity]
GO
ALTER TABLE [dbo].[TblOHSMonitoringResponsible]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSMonitoringResponsible_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSMonitoringResponsible] CHECK CONSTRAINT [FK_TblOHSMonitoringResponsible_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSMonitoringResponsible]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSMonitoringResponsible_TblOHSMonitoringAndMeasurement] FOREIGN KEY([MonitoringAndMeasurementID])
REFERENCES [dbo].[TblOHSMonitoringAndMeasurement] ([MonitoringAndMeasurementID])
GO
ALTER TABLE [dbo].[TblOHSMonitoringResponsible] CHECK CONSTRAINT [FK_TblOHSMonitoringResponsible_TblOHSMonitoringAndMeasurement]
GO
ALTER TABLE [dbo].[TblOHSPreventionRiskAssessRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSPreventionRiskAssessRelations_TblOHSControlPrevention] FOREIGN KEY([ControlPreventionID])
REFERENCES [dbo].[TblOHSControlPrevention] ([ControlPreventionID])
GO
ALTER TABLE [dbo].[TblOHSPreventionRiskAssessRelations] CHECK CONSTRAINT [FK_TblOHSPreventionRiskAssessRelations_TblOHSControlPrevention]
GO
ALTER TABLE [dbo].[TblOHSPreventionRiskAssessRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSPreventionRiskAssessRelations_TblOHSRiskAssessmentTable] FOREIGN KEY([RiskAssessmentID])
REFERENCES [dbo].[TblOHSRiskAssessmentTable] ([RiskAssessmentID])
GO
ALTER TABLE [dbo].[TblOHSPreventionRiskAssessRelations] CHECK CONSTRAINT [FK_TblOHSPreventionRiskAssessRelations_TblOHSRiskAssessmentTable]
GO
ALTER TABLE [dbo].[TblOHSRemakWorkAccRootCause]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRemakWorkAccRootCause_TblOHSRootCauseType] FOREIGN KEY([RootCauseTypeID])
REFERENCES [dbo].[TblOHSRootCauseType] ([RootCauseTypeId])
GO
ALTER TABLE [dbo].[TblOHSRemakWorkAccRootCause] CHECK CONSTRAINT [FK_TblOHSRemakWorkAccRootCause_TblOHSRootCauseType]
GO
ALTER TABLE [dbo].[TblOHSRemakWorkAccRootCause]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRemakWorkAccRootCause_TblTypeDetail] FOREIGN KEY([AccidentTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblOHSRemakWorkAccRootCause] CHECK CONSTRAINT [FK_TblOHSRemakWorkAccRootCause_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblOHSRisk]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRisk_TblOHSDangerSource] FOREIGN KEY([OHSRiskSourceID])
REFERENCES [dbo].[TblOHSDangerSource] ([DangerSourceID])
GO
ALTER TABLE [dbo].[TblOHSRisk] CHECK CONSTRAINT [FK_TblOHSRisk_TblOHSDangerSource]
GO
ALTER TABLE [dbo].[TblOHSRiskAssesDocumentRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssesDocumentRelations_TblMasterRegulationDetail] FOREIGN KEY([OHSDocumentID])
REFERENCES [dbo].[TblMasterRegulationDetail] ([MasterRegulationDetailID])
GO
ALTER TABLE [dbo].[TblOHSRiskAssesDocumentRelations] CHECK CONSTRAINT [FK_TblOHSRiskAssesDocumentRelations_TblMasterRegulationDetail]
GO
ALTER TABLE [dbo].[TblOHSRiskAssesDocumentRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssesDocumentRelations_TblOHSRiskAssessmentTable] FOREIGN KEY([RiskAssessmentID])
REFERENCES [dbo].[TblOHSRiskAssessmentTable] ([RiskAssessmentID])
GO
ALTER TABLE [dbo].[TblOHSRiskAssesDocumentRelations] CHECK CONSTRAINT [FK_TblOHSRiskAssesDocumentRelations_TblOHSRiskAssessmentTable]
GO
ALTER TABLE [dbo].[TblOHSRiskAssessmentTable]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssessmentTable_TblOHSDangerStatus] FOREIGN KEY([DangerStatusID])
REFERENCES [dbo].[TblOHSDangerStatus] ([DangerStatusID])
GO
ALTER TABLE [dbo].[TblOHSRiskAssessmentTable] CHECK CONSTRAINT [FK_TblOHSRiskAssessmentTable_TblOHSDangerStatus]
GO
ALTER TABLE [dbo].[TblOHSRiskAssessmentTable]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssessmentTable_TblOHSRisk] FOREIGN KEY([RiskID])
REFERENCES [dbo].[TblOHSRisk] ([RiskID])
GO
ALTER TABLE [dbo].[TblOHSRiskAssessmentTable] CHECK CONSTRAINT [FK_TblOHSRiskAssessmentTable_TblOHSRisk]
GO
ALTER TABLE [dbo].[TblOHSRiskAssessmentTable]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssessmentTable_TblOHSRiskEssesmentTableLocation] FOREIGN KEY([RiskAssessmentLocID])
REFERENCES [dbo].[TblOHSRiskEssesmentTableLocation] ([RiskAssessmentLocID])
GO
ALTER TABLE [dbo].[TblOHSRiskAssessmentTable] CHECK CONSTRAINT [FK_TblOHSRiskAssessmentTable_TblOHSRiskEssesmentTableLocation]
GO
ALTER TABLE [dbo].[TblOHSRiskEssesmentTableLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskEssesmentTableLocation_TblEmployee] FOREIGN KEY([OHSExpertEmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSRiskEssesmentTableLocation] CHECK CONSTRAINT [FK_TblOHSRiskEssesmentTableLocation_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSRiskEssesmentTableLocation]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskEssesmentTableLocation_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblOHSRiskEssesmentTableLocation] CHECK CONSTRAINT [FK_TblOHSRiskEssesmentTableLocation_TblLocation]
GO
ALTER TABLE [dbo].[TblOHSRiskRepresentativeEmployeeRelation]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskExpertEmployeeRelation_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSRiskRepresentativeEmployeeRelation] CHECK CONSTRAINT [FK_TblOHSRiskExpertEmployeeRelation_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSRiskRepresentativeEmployeeRelation]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskExpertEmployeeRelation_TblOHSRiskEssesmentTableLocation] FOREIGN KEY([RiskAssessmentLocID])
REFERENCES [dbo].[TblOHSRiskEssesmentTableLocation] ([RiskAssessmentLocID])
GO
ALTER TABLE [dbo].[TblOHSRiskRepresentativeEmployeeRelation] CHECK CONSTRAINT [FK_TblOHSRiskExpertEmployeeRelation_TblOHSRiskEssesmentTableLocation]
GO
ALTER TABLE [dbo].[TblOHSRiskSupportEmployeeRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssessEmployeeRelations_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSRiskSupportEmployeeRelations] CHECK CONSTRAINT [FK_TblOHSRiskAssessEmployeeRelations_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSRiskSupportEmployeeRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSRiskAssessEmployeeRelations_TblOHSRiskEssesmentTableLocation] FOREIGN KEY([RiskAssessmentLocID])
REFERENCES [dbo].[TblOHSRiskEssesmentTableLocation] ([RiskAssessmentLocID])
GO
ALTER TABLE [dbo].[TblOHSRiskSupportEmployeeRelations] CHECK CONSTRAINT [FK_TblOHSRiskAssessEmployeeRelations_TblOHSRiskEssesmentTableLocation]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentCureRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentCureRelationship_TblOHSWorkAccident] FOREIGN KEY([WorkAccidentID])
REFERENCES [dbo].[TblOHSWorkAccident] ([WorkAccidentID])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentCureRelationship] CHECK CONSTRAINT [FK_TblOHSWorkAccidentCureRelationship_TblOHSWorkAccident]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentCureRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentCureRelationship_TblTypeDetail] FOREIGN KEY([CureID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentCureRelationship] CHECK CONSTRAINT [FK_TblOHSWorkAccidentCureRelationship_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentRemak]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentRemak_TblEmployee] FOREIGN KEY([SaveEmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentRemak] CHECK CONSTRAINT [FK_TblOHSWorkAccidentRemak_TblEmployee]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentRemak]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentRemak_TblOHSRemakWorkAccRootCause] FOREIGN KEY([RootCauseID])
REFERENCES [dbo].[TblOHSRemakWorkAccRootCause] ([RootCauseID])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentRemak] CHECK CONSTRAINT [FK_TblOHSWorkAccidentRemak_TblOHSRemakWorkAccRootCause]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentRemak]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentRemak_TblTypeDetail] FOREIGN KEY([WorkAccAndRemakID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentRemak] CHECK CONSTRAINT [FK_TblOHSWorkAccidentRemak_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentTypeRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentTypeRelationship_TblOHSWorkAccident] FOREIGN KEY([WorkAccidentID])
REFERENCES [dbo].[TblOHSWorkAccident] ([WorkAccidentID])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentTypeRelationship] CHECK CONSTRAINT [FK_TblOHSWorkAccidentTypeRelationship_TblOHSWorkAccident]
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentTypeRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblOHSWorkAccidentTypeRelationship_TblTypeDetail] FOREIGN KEY([AccidentTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblOHSWorkAccidentTypeRelationship] CHECK CONSTRAINT [FK_TblOHSWorkAccidentTypeRelationship_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblPeriodDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodDetail_TblPeriod] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[TblPeriod] ([PeriodID])
GO
ALTER TABLE [dbo].[TblPeriodDetail] CHECK CONSTRAINT [FK_TblPeriodDetail_TblPeriod]
GO
ALTER TABLE [dbo].[TblPeriodicProviderService]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderService_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderService] CHECK CONSTRAINT [FK_TblPeriodicProviderService_TblDocument]
GO
ALTER TABLE [dbo].[TblPeriodicProviderService]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderService_TblLabSample] FOREIGN KEY([LabSampleID])
REFERENCES [dbo].[TblLabSample] ([SampleID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderService] CHECK CONSTRAINT [FK_TblPeriodicProviderService_TblLabSample]
GO
ALTER TABLE [dbo].[TblPeriodicProviderService]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderService_TblLocation] FOREIGN KEY([LocationIdD])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderService] CHECK CONSTRAINT [FK_TblPeriodicProviderService_TblLocation]
GO
ALTER TABLE [dbo].[TblPeriodicProviderService]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderService_TblPeriod] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[TblPeriod] ([PeriodID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderService] CHECK CONSTRAINT [FK_TblPeriodicProviderService_TblPeriod]
GO
ALTER TABLE [dbo].[TblPeriodicProviderService]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderService_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderService] CHECK CONSTRAINT [FK_TblPeriodicProviderService_TblProvider]
GO
ALTER TABLE [dbo].[TblPeriodicProviderServiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderServiceDetail_TblPeriodicProviderService] FOREIGN KEY([PeriodicServiceID])
REFERENCES [dbo].[TblPeriodicProviderService] ([PerServiceID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderServiceDetail] CHECK CONSTRAINT [FK_TblPeriodicProviderServiceDetail_TblPeriodicProviderService]
GO
ALTER TABLE [dbo].[TblPeriodicProviderServiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblPeriodicProviderServiceDetail_TblProviderServices] FOREIGN KEY([ProviderServiceID])
REFERENCES [dbo].[TblProviderServices] ([ProviderServiceID])
GO
ALTER TABLE [dbo].[TblPeriodicProviderServiceDetail] CHECK CONSTRAINT [FK_TblPeriodicProviderServiceDetail_TblProviderServices]
GO
ALTER TABLE [dbo].[TblPermission]  WITH CHECK ADD  CONSTRAINT [FK_TblPermission_TblAuditor] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblPermission] CHECK CONSTRAINT [FK_TblPermission_TblAuditor]
GO
ALTER TABLE [dbo].[TblPleasure]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasure_TblEmployee] FOREIGN KEY([ProjectMannager])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblPleasure] CHECK CONSTRAINT [FK_TblPleasure_TblEmployee]
GO
ALTER TABLE [dbo].[TblPleasure]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasure_TblLocation] FOREIGN KEY([LcoationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblPleasure] CHECK CONSTRAINT [FK_TblPleasure_TblLocation]
GO
ALTER TABLE [dbo].[TblPleasure]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasure_TblPleasureDeliverType] FOREIGN KEY([DeliverID])
REFERENCES [dbo].[TblPleasureDeliverType] ([DeliverID])
GO
ALTER TABLE [dbo].[TblPleasure] CHECK CONSTRAINT [FK_TblPleasure_TblPleasureDeliverType]
GO
ALTER TABLE [dbo].[TblPleasure]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasure_TblPleasureExplanationHelp] FOREIGN KEY([PleasureExpID])
REFERENCES [dbo].[TblPleasureExplanationHelp] ([PleasureExpID])
GO
ALTER TABLE [dbo].[TblPleasure] CHECK CONSTRAINT [FK_TblPleasure_TblPleasureExplanationHelp]
GO
ALTER TABLE [dbo].[TblPleasure]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasure_TblPleasureForeignSubstance] FOREIGN KEY([substanceID])
REFERENCES [dbo].[TblPleasureForeignSubstance] ([Substance])
GO
ALTER TABLE [dbo].[TblPleasure] CHECK CONSTRAINT [FK_TblPleasure_TblPleasureForeignSubstance]
GO
ALTER TABLE [dbo].[TblPleasure]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasure_TblPleasureRootCause] FOREIGN KEY([RootCauseID])
REFERENCES [dbo].[TblPleasureRootCause] ([RootCauseID])
GO
ALTER TABLE [dbo].[TblPleasure] CHECK CONSTRAINT [FK_TblPleasure_TblPleasureRootCause]
GO
ALTER TABLE [dbo].[TblPleasureActions]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureActions_TblPleasure] FOREIGN KEY([PleasureID])
REFERENCES [dbo].[TblPleasure] ([PleasureID])
GO
ALTER TABLE [dbo].[TblPleasureActions] CHECK CONSTRAINT [FK_TblPleasureActions_TblPleasure]
GO
ALTER TABLE [dbo].[TblPleasureActions]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureActions_TblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[TblUser] ([UserID])
GO
ALTER TABLE [dbo].[TblPleasureActions] CHECK CONSTRAINT [FK_TblPleasureActions_TblUser]
GO
ALTER TABLE [dbo].[TblPleasureDocumentRelation]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureDocumentRelation_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblPleasureDocumentRelation] CHECK CONSTRAINT [FK_TblPleasureDocumentRelation_TblDocument]
GO
ALTER TABLE [dbo].[TblPleasureDocumentRelation]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureDocumentRelation_TblPleasure] FOREIGN KEY([PleasureID])
REFERENCES [dbo].[TblPleasure] ([PleasureID])
GO
ALTER TABLE [dbo].[TblPleasureDocumentRelation] CHECK CONSTRAINT [FK_TblPleasureDocumentRelation_TblPleasure]
GO
ALTER TABLE [dbo].[TblPleasureIntoxication]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureIntoxication_TblPleasure] FOREIGN KEY([PleasureID])
REFERENCES [dbo].[TblPleasure] ([PleasureID])
GO
ALTER TABLE [dbo].[TblPleasureIntoxication] CHECK CONSTRAINT [FK_TblPleasureIntoxication_TblPleasure]
GO
ALTER TABLE [dbo].[TblPleasureProvider]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureProvider_TblPleasure] FOREIGN KEY([PleasureID])
REFERENCES [dbo].[TblPleasure] ([PleasureID])
GO
ALTER TABLE [dbo].[TblPleasureProvider] CHECK CONSTRAINT [FK_TblPleasureProvider_TblPleasure]
GO
ALTER TABLE [dbo].[TblPleasureProvider]  WITH CHECK ADD  CONSTRAINT [FK_TblPleasureProvider_TblProvider] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblPleasureProvider] CHECK CONSTRAINT [FK_TblPleasureProvider_TblProvider]
GO
ALTER TABLE [dbo].[TblProcedure]  WITH CHECK ADD  CONSTRAINT [FK_TblProcedure_TblTypeDetail] FOREIGN KEY([DocumentProcessID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblProcedure] CHECK CONSTRAINT [FK_TblProcedure_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblProcedureDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblProcedureDocument_TblProcedure] FOREIGN KEY([ProcedureID])
REFERENCES [dbo].[TblProcedure] ([ProcedureID])
GO
ALTER TABLE [dbo].[TblProcedureDocument] CHECK CONSTRAINT [FK_TblProcedureDocument_TblProcedure]
GO
ALTER TABLE [dbo].[TblProvider]  WITH CHECK ADD  CONSTRAINT [FK_TblProvider_TblTypeDetail] FOREIGN KEY([ProviderTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblProvider] CHECK CONSTRAINT [FK_TblProvider_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblProvider]  WITH CHECK ADD  CONSTRAINT [FK_TblProvider_TblVirtualRegion] FOREIGN KEY([VirtualRegionID])
REFERENCES [dbo].[TblVirtualRegion] ([VirtualRegionID])
GO
ALTER TABLE [dbo].[TblProvider] CHECK CONSTRAINT [FK_TblProvider_TblVirtualRegion]
GO
ALTER TABLE [dbo].[TblProviderAccreditionsDocuments]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAccreditionsDocuments_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblProviderAccreditionsDocuments] CHECK CONSTRAINT [FK_TblProviderAccreditionsDocuments_TblDocument]
GO
ALTER TABLE [dbo].[TblProviderAuditExperts]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditExperts_TblExpert] FOREIGN KEY([ExpertID])
REFERENCES [dbo].[TblExpert] ([ExpertID])
GO
ALTER TABLE [dbo].[TblProviderAuditExperts] CHECK CONSTRAINT [FK_TblProviderAuditExperts_TblExpert]
GO
ALTER TABLE [dbo].[TblProviderAuditExperts]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditExperts_TblProductCategory] FOREIGN KEY([ProductCatID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblProviderAuditExperts] CHECK CONSTRAINT [FK_TblProviderAuditExperts_TblProductCategory]
GO
ALTER TABLE [dbo].[TblProviderAuditPeriod]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditPeriod_TblPeriod] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[TblPeriod] ([PeriodID])
GO
ALTER TABLE [dbo].[TblProviderAuditPeriod] CHECK CONSTRAINT [FK_TblProviderAuditPeriod_TblPeriod]
GO
ALTER TABLE [dbo].[TblProviderAuditPeriod]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditPeriod_TblProductCategory] FOREIGN KEY([ProductCatID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblProviderAuditPeriod] CHECK CONSTRAINT [FK_TblProviderAuditPeriod_TblProductCategory]
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItems]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditYearPlanItems_TblAuditor] FOREIGN KEY([AuditorID])
REFERENCES [dbo].[TblAuditor] ([AuditorID])
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItems] CHECK CONSTRAINT [FK_TblProviderAuditYearPlanItems_TblAuditor]
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItems]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditYearPlanItems_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItems] CHECK CONSTRAINT [FK_TblProviderAuditYearPlanItems_TblProvider]
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItems]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditYearPlanItems_TblProviderAuditYearPlans] FOREIGN KEY([ProviderAuditYearPlanID])
REFERENCES [dbo].[TblProviderAuditYearPlans] ([ProviderAuditYearPlanID])
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItems] CHECK CONSTRAINT [FK_TblProviderAuditYearPlanItems_TblProviderAuditYearPlans]
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItemStatusChanges]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderAuditYearPlanItemStatusChanges_TblProviderAuditYearPlanItems] FOREIGN KEY([PlanItemID])
REFERENCES [dbo].[TblProviderAuditYearPlanItems] ([ProviderAuditYearPlanItemID])
GO
ALTER TABLE [dbo].[TblProviderAuditYearPlanItemStatusChanges] CHECK CONSTRAINT [FK_TblProviderAuditYearPlanItemStatusChanges_TblProviderAuditYearPlanItems]
GO
ALTER TABLE [dbo].[TblProviderProblem]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderProblem_TblDepartment] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[TblDepartment] ([DepartmentID])
GO
ALTER TABLE [dbo].[TblProviderProblem] CHECK CONSTRAINT [FK_TblProviderProblem_TblDepartment]
GO
ALTER TABLE [dbo].[TblProviderProblem]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderProblem_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblProviderProblem] CHECK CONSTRAINT [FK_TblProviderProblem_TblLocation]
GO
ALTER TABLE [dbo].[TblProviderProblem]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderProblem_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblProviderProblem] CHECK CONSTRAINT [FK_TblProviderProblem_TblProvider]
GO
ALTER TABLE [dbo].[TblProviderProblemDocument]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderProblemDocument_TblProviderProblem] FOREIGN KEY([ProviderProblemID])
REFERENCES [dbo].[TblProviderProblem] ([ProviderProblemID])
GO
ALTER TABLE [dbo].[TblProviderProblemDocument] CHECK CONSTRAINT [FK_TblProviderProblemDocument_TblProviderProblem]
GO
ALTER TABLE [dbo].[TblProviderProblemImpurityRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderProblemImpurityRelationship_TblPleasureExplanationHelp] FOREIGN KEY([ImpurityID])
REFERENCES [dbo].[TblPleasureExplanationHelp] ([PleasureExpID])
GO
ALTER TABLE [dbo].[TblProviderProblemImpurityRelationship] CHECK CONSTRAINT [FK_TblProviderProblemImpurityRelationship_TblPleasureExplanationHelp]
GO
ALTER TABLE [dbo].[TblProviderProblemImpurityRelationship]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderProblemImpurityRelationship_TblProviderProblem] FOREIGN KEY([ProviderProblemID])
REFERENCES [dbo].[TblProviderProblem] ([ProviderProblemID])
GO
ALTER TABLE [dbo].[TblProviderProblemImpurityRelationship] CHECK CONSTRAINT [FK_TblProviderProblemImpurityRelationship_TblProviderProblem]
GO
ALTER TABLE [dbo].[TblProviderQuestionSet]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderQuestionSet_TblProductCategory] FOREIGN KEY([CatID])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblProviderQuestionSet] CHECK CONSTRAINT [FK_TblProviderQuestionSet_TblProductCategory]
GO
ALTER TABLE [dbo].[TblProviderQuestionSet]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderQuestionSet_TblQuestionSet] FOREIGN KEY([SetID])
REFERENCES [dbo].[TblQuestionSet] ([SetID])
GO
ALTER TABLE [dbo].[TblProviderQuestionSet] CHECK CONSTRAINT [FK_TblProviderQuestionSet_TblQuestionSet]
GO
ALTER TABLE [dbo].[TblProviderServicePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlan_TblEvidence] FOREIGN KEY([EvidenceID])
REFERENCES [dbo].[TblEvidence] ([EvidenceID])
GO
ALTER TABLE [dbo].[TblProviderServicePlan] CHECK CONSTRAINT [FK_TblProviderServicePlan_TblEvidence]
GO
ALTER TABLE [dbo].[TblProviderServicePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlan_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblProviderServicePlan] CHECK CONSTRAINT [FK_TblProviderServicePlan_TblLocation]
GO
ALTER TABLE [dbo].[TblProviderServicePlan]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlan_TblProviderServices] FOREIGN KEY([ProviderServiceID])
REFERENCES [dbo].[TblProviderServices] ([ProviderServiceID])
GO
ALTER TABLE [dbo].[TblProviderServicePlan] CHECK CONSTRAINT [FK_TblProviderServicePlan_TblProviderServices]
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlanDetail_TblEvidence] FOREIGN KEY([EvidenceID])
REFERENCES [dbo].[TblEvidence] ([EvidenceID])
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail] CHECK CONSTRAINT [FK_TblProviderServicePlanDetail_TblEvidence]
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlanDetail_TblMaterialServices] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[TblMaterialServices] ([MaterialID])
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail] CHECK CONSTRAINT [FK_TblProviderServicePlanDetail_TblMaterialServices]
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlanDetail_TblProductCategory] FOREIGN KEY([CatId])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail] CHECK CONSTRAINT [FK_TblProviderServicePlanDetail_TblProductCategory]
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServicePlanDetail_TblProviderServicePlan] FOREIGN KEY([PlanID])
REFERENCES [dbo].[TblProviderServicePlan] ([PlanID])
GO
ALTER TABLE [dbo].[TblProviderServicePlanDetail] CHECK CONSTRAINT [FK_TblProviderServicePlanDetail_TblProviderServicePlan]
GO
ALTER TABLE [dbo].[TblProviderServices]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServices_TblMaterialServices] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[TblMaterialServices] ([MaterialID])
GO
ALTER TABLE [dbo].[TblProviderServices] CHECK CONSTRAINT [FK_TblProviderServices_TblMaterialServices]
GO
ALTER TABLE [dbo].[TblProviderServices]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServices_TblProductCategory] FOREIGN KEY([CatId])
REFERENCES [dbo].[TblProductCategory] ([CatID])
GO
ALTER TABLE [dbo].[TblProviderServices] CHECK CONSTRAINT [FK_TblProviderServices_TblProductCategory]
GO
ALTER TABLE [dbo].[TblProviderServices]  WITH CHECK ADD  CONSTRAINT [FK_TblProviderServices_TblProvider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblProviderServices] CHECK CONSTRAINT [FK_TblProviderServices_TblProvider]
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs]  WITH CHECK ADD  CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabMetots] FOREIGN KEY([LabMetotId])
REFERENCES [dbo].[TblLabMetots] ([LabMetotId])
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs] CHECK CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabMetots]
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs]  WITH CHECK ADD  CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabNumuneAltGrups] FOREIGN KEY([LabNumuneAltGrupId])
REFERENCES [dbo].[TblLabNumuneAltGrups] ([LabNumuneAltGrupId])
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs] CHECK CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabNumuneAltGrups]
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs]  WITH CHECK ADD  CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabNumuneGrups] FOREIGN KEY([LabNumuneGrupId])
REFERENCES [dbo].[TblLabNumuneGrups] ([LabNumuneGrupId])
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs] CHECK CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabNumuneGrups]
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs]  WITH CHECK ADD  CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabParameters] FOREIGN KEY([LabParametersId])
REFERENCES [dbo].[TblLabParameters] ([LabParametersId])
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs] CHECK CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblLabParameters]
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs]  WITH CHECK ADD  CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblProvideSampleParametersMatchs] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[TblProvider] ([ProviderID])
GO
ALTER TABLE [dbo].[TblProvideSampleParametersMatchs] CHECK CONSTRAINT [FK_TblProvideSampleParametersMatchs_TblProvideSampleParametersMatchs]
GO
ALTER TABLE [dbo].[TblQuestion]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestion_TblQuestionScale] FOREIGN KEY([ScaleID])
REFERENCES [dbo].[TblQuestionScale] ([ScaleID])
GO
ALTER TABLE [dbo].[TblQuestion] CHECK CONSTRAINT [FK_TblQuestion_TblQuestionScale]
GO
ALTER TABLE [dbo].[TblQuestion]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestion_TblTypeDetail] FOREIGN KEY([QuestionTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblQuestion] CHECK CONSTRAINT [FK_TblQuestion_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblQuestionScaleDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestionScaleDetail_TblQuestionScale] FOREIGN KEY([ScaleID])
REFERENCES [dbo].[TblQuestionScale] ([ScaleID])
GO
ALTER TABLE [dbo].[TblQuestionScaleDetail] CHECK CONSTRAINT [FK_TblQuestionScaleDetail_TblQuestionScale]
GO
ALTER TABLE [dbo].[TblQuestionSet]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestionSet_TblQuesSetFormInfo] FOREIGN KEY([SetInfoID])
REFERENCES [dbo].[TblQuesSetFormInfo] ([SetInfoID])
GO
ALTER TABLE [dbo].[TblQuestionSet] CHECK CONSTRAINT [FK_TblQuestionSet_TblQuesSetFormInfo]
GO
ALTER TABLE [dbo].[TblQuestionSetItems]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestionSetItems_TblQuestion] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[TblQuestion] ([QuestionID])
GO
ALTER TABLE [dbo].[TblQuestionSetItems] CHECK CONSTRAINT [FK_TblQuestionSetItems_TblQuestion]
GO
ALTER TABLE [dbo].[TblQuestionSetItems]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestionSetItems_TblQuestionSet] FOREIGN KEY([SetID])
REFERENCES [dbo].[TblQuestionSet] ([SetID])
GO
ALTER TABLE [dbo].[TblQuestionSetItems] CHECK CONSTRAINT [FK_TblQuestionSetItems_TblQuestionSet]
GO
ALTER TABLE [dbo].[TblQuestionSetType]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestionSetType_TblQuestionSet] FOREIGN KEY([SetID])
REFERENCES [dbo].[TblQuestionSet] ([SetID])
GO
ALTER TABLE [dbo].[TblQuestionSetType] CHECK CONSTRAINT [FK_TblQuestionSetType_TblQuestionSet]
GO
ALTER TABLE [dbo].[TblQuestionSetType]  WITH CHECK ADD  CONSTRAINT [FK_TblQuestionSetType_TblTypeDetail] FOREIGN KEY([SetCategoryTypeID])
REFERENCES [dbo].[TblTypeDetail] ([TypeDetailId])
GO
ALTER TABLE [dbo].[TblQuestionSetType] CHECK CONSTRAINT [FK_TblQuestionSetType_TblTypeDetail]
GO
ALTER TABLE [dbo].[TblReceiverUserMessage]  WITH CHECK ADD  CONSTRAINT [FK_TblReceiverUserMessage_TblMessageType] FOREIGN KEY([MessageTypeID])
REFERENCES [dbo].[TblMessageType] ([MessageTypeID])
GO
ALTER TABLE [dbo].[TblReceiverUserMessage] CHECK CONSTRAINT [FK_TblReceiverUserMessage_TblMessageType]
GO
ALTER TABLE [dbo].[TblReceiverUserMessage]  WITH CHECK ADD  CONSTRAINT [FK_TblReceiverUserMessage_TblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[TblUser] ([UserID])
GO
ALTER TABLE [dbo].[TblReceiverUserMessage] CHECK CONSTRAINT [FK_TblReceiverUserMessage_TblUser]
GO
ALTER TABLE [dbo].[TblRegulation]  WITH CHECK ADD  CONSTRAINT [FK_TblRegulation_TblProcedureDocument] FOREIGN KEY([ProcedureDocumentID])
REFERENCES [dbo].[TblProcedureDocument] ([ProcedureDocumentID])
GO
ALTER TABLE [dbo].[TblRegulation] CHECK CONSTRAINT [FK_TblRegulation_TblProcedureDocument]
GO
ALTER TABLE [dbo].[TblServicesMinutes]  WITH CHECK ADD  CONSTRAINT [FK_TblServicesMinutes_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblServicesMinutes] CHECK CONSTRAINT [FK_TblServicesMinutes_TblEmployee]
GO
ALTER TABLE [dbo].[TblServicesMinutes]  WITH CHECK ADD  CONSTRAINT [FK_TblServicesMinutes_TblLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblServicesMinutes] CHECK CONSTRAINT [FK_TblServicesMinutes_TblLocation]
GO
ALTER TABLE [dbo].[TblSourceTask]  WITH CHECK ADD  CONSTRAINT [FK_TblSourceTask_TblTask] FOREIGN KEY([TaskID])
REFERENCES [dbo].[TblTask] ([TaskID])
GO
ALTER TABLE [dbo].[TblSourceTask] CHECK CONSTRAINT [FK_TblSourceTask_TblTask]
GO
ALTER TABLE [dbo].[TblSurvey]  WITH CHECK ADD  CONSTRAINT [FK_TblSurvey_TblLocation] FOREIGN KEY([LocationId])
REFERENCES [dbo].[TblLocation] ([LocationID])
GO
ALTER TABLE [dbo].[TblSurvey] CHECK CONSTRAINT [FK_TblSurvey_TblLocation]
GO
ALTER TABLE [dbo].[TblSurvey]  WITH CHECK ADD  CONSTRAINT [FK_TblSurvey_TblSurveyor] FOREIGN KEY([SurveyorId])
REFERENCES [dbo].[TblSurveyor] ([SurveyorId])
GO
ALTER TABLE [dbo].[TblSurvey] CHECK CONSTRAINT [FK_TblSurvey_TblSurveyor]
GO
ALTER TABLE [dbo].[TblSurvey]  WITH CHECK ADD  CONSTRAINT [FK_TblSurvey_TblSurveyType] FOREIGN KEY([SurveyTypeId])
REFERENCES [dbo].[TblSurveyType] ([SurveyTypeId])
GO
ALTER TABLE [dbo].[TblSurvey] CHECK CONSTRAINT [FK_TblSurvey_TblSurveyType]
GO
ALTER TABLE [dbo].[TblSurveyAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TblSurveyAnswer_TblSurvey] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[TblSurvey] ([SurveyId])
GO
ALTER TABLE [dbo].[TblSurveyAnswer] CHECK CONSTRAINT [FK_TblSurveyAnswer_TblSurvey]
GO
ALTER TABLE [dbo].[TblSurveyAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TblSurveyAnswer_TblSurveyAnswerType] FOREIGN KEY([TypeId])
REFERENCES [dbo].[TblSurveyAnswerType] ([AnswerTypeId])
GO
ALTER TABLE [dbo].[TblSurveyAnswer] CHECK CONSTRAINT [FK_TblSurveyAnswer_TblSurveyAnswerType]
GO
ALTER TABLE [dbo].[TblSurveyAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TblSurveyAnswer_TblSurveyQuestion] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[TblSurveyQuestion] ([SurveyQuestionId])
GO
ALTER TABLE [dbo].[TblSurveyAnswer] CHECK CONSTRAINT [FK_TblSurveyAnswer_TblSurveyQuestion]
GO
ALTER TABLE [dbo].[TblSurveyQuestion]  WITH CHECK ADD  CONSTRAINT [FK_TblSurveyQuestion_TblSurveyQuestionTitle] FOREIGN KEY([TitleId])
REFERENCES [dbo].[TblSurveyQuestionTitle] ([QuestionTitleId])
GO
ALTER TABLE [dbo].[TblSurveyQuestion] CHECK CONSTRAINT [FK_TblSurveyQuestion_TblSurveyQuestionTitle]
GO
ALTER TABLE [dbo].[TblSurveyTitleType]  WITH CHECK ADD  CONSTRAINT [FK_TblSurveyTitleType_TblSurveyQuestionTitle] FOREIGN KEY([QuestionTitleId])
REFERENCES [dbo].[TblSurveyQuestionTitle] ([QuestionTitleId])
GO
ALTER TABLE [dbo].[TblSurveyTitleType] CHECK CONSTRAINT [FK_TblSurveyTitleType_TblSurveyQuestionTitle]
GO
ALTER TABLE [dbo].[TblSurveyTitleType]  WITH CHECK ADD  CONSTRAINT [FK_TblSurveyTitleType_TblSurveyType] FOREIGN KEY([SurveyTypeId])
REFERENCES [dbo].[TblSurveyType] ([SurveyTypeId])
GO
ALTER TABLE [dbo].[TblSurveyTitleType] CHECK CONSTRAINT [FK_TblSurveyTitleType_TblSurveyType]
GO
ALTER TABLE [dbo].[TblTarget]  WITH CHECK ADD  CONSTRAINT [FK_TblTarget_TblTargetType] FOREIGN KEY([TargetTypeID])
REFERENCES [dbo].[TblTargetType] ([TargetTypeID])
GO
ALTER TABLE [dbo].[TblTarget] CHECK CONSTRAINT [FK_TblTarget_TblTargetType]
GO
ALTER TABLE [dbo].[TblTargetMeasurement]  WITH CHECK ADD  CONSTRAINT [FK_TblTargetMeasurement_TblTarget] FOREIGN KEY([TargetID])
REFERENCES [dbo].[TblTarget] ([TargetID])
GO
ALTER TABLE [dbo].[TblTargetMeasurement] CHECK CONSTRAINT [FK_TblTargetMeasurement_TblTarget]
GO
ALTER TABLE [dbo].[TblTempGroupMajor]  WITH CHECK ADD  CONSTRAINT [FK_TblTempGroupMajor_TblAuditRealizeDetail] FOREIGN KEY([AuditReDetID])
REFERENCES [dbo].[TblAuditRealizeDetail] ([AudReDetID])
GO
ALTER TABLE [dbo].[TblTempGroupMajor] CHECK CONSTRAINT [FK_TblTempGroupMajor_TblAuditRealizeDetail]
GO
ALTER TABLE [dbo].[TblTowns]  WITH CHECK ADD  CONSTRAINT [FK_TblTowns_TblCity] FOREIGN KEY([CityID])
REFERENCES [dbo].[TblCity] ([CityID])
GO
ALTER TABLE [dbo].[TblTowns] CHECK CONSTRAINT [FK_TblTowns_TblCity]
GO
ALTER TABLE [dbo].[TblTrainers]  WITH CHECK ADD  CONSTRAINT [FK_TblTrainers_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblTrainers] CHECK CONSTRAINT [FK_TblTrainers_TblEmployee]
GO
ALTER TABLE [dbo].[TblTraining]  WITH CHECK ADD  CONSTRAINT [FK_TblTraining_TblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[TblDocument] ([DocumentID])
GO
ALTER TABLE [dbo].[TblTraining] CHECK CONSTRAINT [FK_TblTraining_TblDocument]
GO
ALTER TABLE [dbo].[TblTraining]  WITH CHECK ADD  CONSTRAINT [FK_TblTraining_TblPeriod] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[TblPeriod] ([PeriodID])
GO
ALTER TABLE [dbo].[TblTraining] CHECK CONSTRAINT [FK_TblTraining_TblPeriod]
GO
ALTER TABLE [dbo].[TblTrainingAssignments]  WITH CHECK ADD  CONSTRAINT [FK_TblTrainingAssignments_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblTrainingAssignments] CHECK CONSTRAINT [FK_TblTrainingAssignments_TblEmployee]
GO
ALTER TABLE [dbo].[TblTrainingPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblTrainingPlan_TblCertificate] FOREIGN KEY([CertificateID])
REFERENCES [dbo].[TblCertificate] ([CertificateID])
GO
ALTER TABLE [dbo].[TblTrainingPlan] CHECK CONSTRAINT [FK_TblTrainingPlan_TblCertificate]
GO
ALTER TABLE [dbo].[TblTrainingPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblTrainingPlan_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblTrainingPlan] CHECK CONSTRAINT [FK_TblTrainingPlan_TblEmployee]
GO
ALTER TABLE [dbo].[TblTrainingPlan]  WITH CHECK ADD  CONSTRAINT [FK_TblTrainingPlan_TblTraining] FOREIGN KEY([TrainingID])
REFERENCES [dbo].[TblTraining] ([TrainingID])
GO
ALTER TABLE [dbo].[TblTrainingPlan] CHECK CONSTRAINT [FK_TblTrainingPlan_TblTraining]
GO
ALTER TABLE [dbo].[TblTypeDetail]  WITH CHECK ADD  CONSTRAINT [FK_TblTypeDetail_TblType] FOREIGN KEY([TypeID])
REFERENCES [dbo].[TblType] ([TypeID])
GO
ALTER TABLE [dbo].[TblTypeDetail] CHECK CONSTRAINT [FK_TblTypeDetail_TblType]
GO
ALTER TABLE [dbo].[TblUpdateFormEmpRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblUpdateFormEmpRelations_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblUpdateFormEmpRelations] CHECK CONSTRAINT [FK_TblUpdateFormEmpRelations_TblEmployee]
GO
ALTER TABLE [dbo].[TblUpdateFormEmpRelations]  WITH CHECK ADD  CONSTRAINT [FK_TblUpdateFormEmpRelations_TblFormMain1] FOREIGN KEY([FormID])
REFERENCES [dbo].[TblFormMain] ([FormID])
GO
ALTER TABLE [dbo].[TblUpdateFormEmpRelations] CHECK CONSTRAINT [FK_TblUpdateFormEmpRelations_TblFormMain1]
GO
ALTER TABLE [dbo].[TblUser]  WITH CHECK ADD  CONSTRAINT [FK_TblUser_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblUser] CHECK CONSTRAINT [FK_TblUser_TblEmployee]
GO
ALTER TABLE [dbo].[TblUserMessage]  WITH CHECK ADD  CONSTRAINT [FK_TblUserMessage_TblMessage] FOREIGN KEY([MessageID])
REFERENCES [dbo].[TblMessage] ([MessageID])
GO
ALTER TABLE [dbo].[TblUserMessage] CHECK CONSTRAINT [FK_TblUserMessage_TblMessage]
GO
ALTER TABLE [dbo].[TblUserMessage]  WITH CHECK ADD  CONSTRAINT [FK_TblUserMessage_TblUser] FOREIGN KEY([ReceiverUserID])
REFERENCES [dbo].[TblUser] ([UserID])
GO
ALTER TABLE [dbo].[TblUserMessage] CHECK CONSTRAINT [FK_TblUserMessage_TblUser]
GO
ALTER TABLE [dbo].[TblVirtualManagement]  WITH CHECK ADD  CONSTRAINT [FK_TblVirtualManagemet_TblEmployee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TblEmployee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TblVirtualManagement] CHECK CONSTRAINT [FK_TblVirtualManagemet_TblEmployee]
GO
ALTER TABLE [dbo].[TblVirtualManagement]  WITH CHECK ADD  CONSTRAINT [FK_TblVirtualManagemet_TblVirtualRegion] FOREIGN KEY([VirtualRegionID])
REFERENCES [dbo].[TblVirtualRegion] ([VirtualRegionID])
GO
ALTER TABLE [dbo].[TblVirtualManagement] CHECK CONSTRAINT [FK_TblVirtualManagemet_TblVirtualRegion]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
/****** Object:  StoredProcedure [dbo].[SP_Average]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Average]
	-- Add the parameters for the stored procedure here
	@auditPlanID int
	
	-- exec SP_Average 30
	--select * from TblAuditPlan where AuditPlanID=30
	-- select * from TblAuditType
AS
BEGIN
declare @locationID int;
declare @providerID int;
declare @isCalculate bit;

	 select @isCalculate= at.AffectPerformance from TblAuditType as at inner join TblAuditPlan as ap on at.AuditTypeID=ap.AuditTypeID where ap.AuditPlanID=@auditPlanID
	 select @locationID= LocationID from TblAuditPlan where AuditPlanID=@auditPlanID;
	 select @providerID= ProviderID from TblAuditPlan where AuditPlanID=@auditPlanID;
     if(@locationID<1 or (@locationID is NULL))
     begin 
       set @locationID=0;
     end


if((@locationID>0) and (@isCalculate=1))

Begin

	if not EXISTS (select LocationID from TblAuditAveragePoint where LocationID= @locationID) 
	  insert into TblAuditAveragePoint(LocationID,AveragePoint) values(@locationID,(select TotalPoint from TblAuditRealize where AuditPlanID=@auditPlanID))
	else
	  update TblAuditAveragePoint set AveragePoint=(select avg(TotalPoint) from TblAuditRealize as r inner join TblAuditPlan as p on r.AuditPlanID=p.AuditPlanID where p.LocationID=@locationID) where LocationID=@locationID		
end
else 
if((@providerID>0) and (@isCalculate=1))
begin
    if not EXISTS (select ProviderID from TblAuditAveragePoint where ProviderID=@providerID) 
	  insert into TblAuditAveragePoint(ProviderID,AveragePoint) values(@providerID,(select TotalPoint from TblAuditRealize where AuditPlanID=@auditPlanID))
	else
	  update TblAuditAveragePoint set AveragePoint=(select avg(TotalPoint) from TblAuditRealize as r inner join TblAuditPlan as p on r.AuditPlanID=p.AuditPlanID where p.ProviderID=@providerID) where ProviderID=@providerID
	end
end
-- exec SP_CalculateAuditPlanTotalPoint 48,1,NULL,NULL,8
-- select *  from TblAuditAveragePoint
GO
/****** Object:  StoredProcedure [dbo].[SP_AverageAuditPointOfLocations]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_AverageAuditPointOfLocations]
@locationID int
AS
BEGIN

declare @averagePoint  nvarchar(50)

select @averagePoint=avg(rl.TotalPoint) from TblAuditRealize as rl inner join TblAuditPlan as pl on rl.AuditPlanID=pl.AuditPlanID where pl.LocationID=@locationID
Select @averagePoint AS AveragePoint
return @AveragePoint
END

-- exec SP_AverageAuditPointOfLocations 10
GO
/****** Object:  StoredProcedure [dbo].[SP_CalculateAuditPlanTotalPoint]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Erdal Özmaskan>
-- Create date: <22.06.2017>
-- Description:	<Gerçekleşen Denetim Planlarında ORtaya Çıkan 3 Farklı Puan Türünü TblAuditRealize Tablosuna Atar>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CalculateAuditPlanTotalPoint]
	-- Add the parameters for the stored procedure here
	@auditPlanID int,
	@auditChoseAction int , --Bu tanım denetim planlamasında insert ve update seçenekelri için tutulmuştur
	@handSamplePoint float NULL,
	@itemSamplePoint float NULL,
	@majorPoint int,
	@tecnicMajorpoint int,
	@infrastruceMajorPoint int,
	@checklistProcessPoint float,
	@checklistTecnicPoint float,
	@checklistnfrastrucePoint float,
	@kaliteProcessPoint float,
	@kaliteTecnicPoint float,
	@kalitenfrastrucePoint float,
	--Uygulama-Teknik ve Uygulama-altyapı puanları hesaplamak için
	@proTecnic float,
	@proInfra float,
	@kaliteProTecnic float,
	@kaliteProInfra float
AS
BEGIN
-- tanımlanan bu değişkenler ile soru sayısı ve girilen kayıt sayısı karşılaştırılarak gerçekleşen denetimin tek denetçi mi yoksa çift denetçi tarafından mı yapıldığını anlamak içindir

declare @auditType bit;
declare @providerID int;

	 select @auditType=  AuditOHS from TblAuditPlan where AuditPlanID=@auditPlanID;
	 select @providerID= ProviderID from TblAuditPlan where AuditPlanID=@auditPlanID;
	 if(@handSamplePoint>100)
	 begin
	 set @handSamplePoint=NULL;
	 end

	  if(@itemSamplePoint>100)
	 begin
	 set @itemSamplePoint=NULL;
	 end
	------Mobilden gelen kayıt çift yaratılıyordu dengelemek için aşağıdaki şartı koydum
	--if((@date is not NULL) and (@totalPoint is NULL))
	--begin
	--set @auditChoseAction=2
	--end
if(@auditType=0 )
begin

if(@auditChoseAction=1)
Begin

	if(@ProviderID is null)
	begin
	insert into TblAuditRealize (AuditPlanID,AuditDate,TotalPoint,TotalProcessPoint,TotalTechPoint,TotalInfraPoint,MajorPoint,InfraMajorPoint,TechMajorPoint,QualityPoint,QualityTecnic,QualityInfra,ProcesTecnicPoint,ProcesInfraPoint,QualityProTecnic,QualityProInfra,ResultTecnicPoint,ResultInfraPoint) 
	 values(@auditPlanID,GetDate(),((@checklistProcessPoint-@majorPoint)*0.8+@kaliteProcessPoint*0.2),@checklistProcessPoint,@checklistTecnicPoint,@checklistnfrastrucePoint ,@majorPoint,@infrastruceMajorPoint,@tecnicMajorpoint,@kaliteProcessPoint,@kaliteTecnicPoint,@kalitenfrastrucePoint,@proTecnic,@proInfra,@kaliteProTecnic,@kaliteProInfra,((@proTecnic-@tecnicMajorpoint)*0.8+@kaliteTecnicPoint*0.2),((@proInfra-@infrastruceMajorPoint)*0.8+@kaliteProInfra*0.2))
	end
	else if(@providerID is not null)
	begin
	insert into TblAuditRealize (AuditPlanID,AuditDate,TotalPoint,TotalProcessPoint,TotalTechPoint,TotalInfraPoint,MajorPoint,InfraMajorPoint,TechMajorPoint,QualityPoint,QualityTecnic,QualityInfra) 
	values(@auditPlanID,GetDate(),(@checklistProcessPoint-@majorPoint),@checklistProcessPoint,@checklistTecnicPoint,@checklistnfrastrucePoint ,@majorPoint,@infrastruceMajorPoint,@tecnicMajorpoint,@kaliteProcessPoint,@kaliteTecnicPoint,@kalitenfrastrucePoint)
	
	end
end
	

	else if(@auditChoseAction=2)
begin
	
	if(@ProviderID is null)
	begin
	update TblAuditRealize set TotalPoint=((@checklistProcessPoint-@majorPoint)*0.8+@kaliteProcessPoint*0.2), 
	AuditDate=GETDATE(),
	TotalProcessPoint=@checklistProcessPoint,
	TotalInfraPoint=@checklistnfrastrucePoint,
	TotalTechPoint=@checklistTecnicPoint,
	QualityPoint=@kaliteProcessPoint,
	QualityTecnic=@kaliteTecnicPoint,
	QualityInfra=@kalitenfrastrucePoint,
	MajorPoint=@majorPoint,
	InfraMajorPoint=@infrastruceMajorPoint,
	TechMajorPoint=@tecnicMajorpoint,
	ProcesTecnicPoint=@proTecnic,
	ProcesInfraPoint=@proInfra,
	QualityProTecnic=@kaliteProTecnic,
	QualityProInfra=@kaliteProInfra,
	ResultTecnicPoint= ((@proTecnic-@tecnicMajorpoint)*0.8+@kaliteTecnicPoint*0.2),
	ResultInfraPoint=((@proInfra-@infrastruceMajorPoint)*0.8+@kaliteProInfra*0.2)
	where AuditPlanID=@auditPlanID
	end
	else  if(@providerID is not null)
	begin
	update TblAuditRealize set TotalPoint=(@checklistProcessPoint-@majorPoint), 
	AuditDate=GETDATE(),
	TotalProcessPoint=@checklistProcessPoint,
	TotalInfraPoint=@checklistnfrastrucePoint,
	TotalTechPoint=@checklistTecnicPoint,
	QualityPoint=@kaliteProcessPoint,
	QualityTecnic=@kaliteTecnicPoint,
	QualityInfra=@kalitenfrastrucePoint,
	MajorPoint=@majorPoint,
	InfraMajorPoint=@infrastruceMajorPoint,
	TechMajorPoint=@tecnicMajorpoint 
	where AuditPlanID=@auditPlanID
	end
end
	else if(@auditChoseAction=3)
	begin 
	if(@handSamplePoint is not NULL and @itemSamplePoint is not NULL)
	begin 
	update TblAuditRealize set HandSamplePoint=@handSamplePoint, ItemSamplePoint=@itemSamplePoint, TotalPoint=(((TotalProcessPoint*0.8+((@handSamplePoint+@itemSamplePoint)*100/20)*0.2)-MajorPoint)*0.8+QualityPoint*0.2),ResultTecnicPoint=(((ProcesTecnicPoint*0.8+((@handSamplePoint+@itemSamplePoint)*100/20)*0.2)-TechMajorPoint)*0.8+QualityProTecnic*0.2),ResultInfraPoint=(((ProcesInfraPoint*0.8+((@handSamplePoint+@itemSamplePoint)*100/20)*0.2)-InfraMajorPoint)*0.8+QualityProInfra*0.2) where AuditPlanID=@auditPlanID
	end
	else if(@handSamplePoint is not NULL and @itemSamplePoint is NULL)
	begin
	update TblAuditRealize set HandSamplePoint=@handSamplePoint,ItemSamplePoint=@itemSamplePoint, TotalPoint=((((TotalProcessPoint)*0.9+((@handSamplePoint)*100/10)*0.1)-MajorPoint)*0.8+QualityPoint*0.2 ),ResultTecnicPoint=(((ProcesTecnicPoint*0.9+((@handSamplePoint)*100/10)*0.1)-TechMajorPoint)*0.8+QualityProTecnic*0.2),ResultInfraPoint=(((ProcesInfraPoint*0.9+((@handSamplePoint)*100/10)*0.1)-InfraMajorPoint)*0.8+QualityProInfra*0.2) where AuditPlanID=@auditPlanID
	end 
	else if(@handSamplePoint is NULL and @itemSamplePoint is not NULL)
	begin 
	update TblAuditRealize set  ItemSamplePoint=@itemSamplePoint,HandSamplePoint=@handSamplePoint, TotalPoint=((((TotalProcessPoint)*0.9+ ((@itemSamplePoint)*100/10)*0.1)-MajorPoint)*0.8+QualityPoint*0.2),ResultTecnicPoint=(((ProcesTecnicPoint*0.9+((@itemSamplePoint)*100/10)*0.1)-TechMajorPoint)*0.8+QualityProTecnic*0.2),ResultInfraPoint=(((ProcesInfraPoint*0.9+((@itemSamplePoint)*100/10)*0.1)-InfraMajorPoint)*0.8+QualityProInfra*0.2) where AuditPlanID=@auditPlanID

	end
	else if(@handSamplePoint is NULL and @itemSamplePoint is NULL)
	begin 
	update TblAuditRealize set HandSamplePoint=@handSamplePoint,ItemSamplePoint=@itemSamplePoint,TotalPoint=((TotalProcessPoint-MajorPoint)*0.8+QualityPoint*0.2),ResultTecnicPoint=((@proTecnic-@tecnicMajorpoint)*0.8+@kaliteTecnicPoint*0.2),ResultInfraPoint=((@proInfra-@infrastruceMajorPoint)*0.8+@kaliteProInfra*0.2) where AuditPlanID=@auditPlanID

	end
end
end
if(@auditType=1)
begin
if(@auditChoseAction=1)
Begin
insert into TblAuditRealize (AuditPlanID,AuditDate,TotalPoint,TotalProcessPoint,TotalTechPoint,TotalInfraPoint,MajorPoint,InfraMajorPoint,TechMajorPoint,QualityPoint,QualityTecnic,QualityInfra) 
values(@auditPlanID,GetDate(),(@kaliteProcessPoint-@majorPoint),@checklistProcessPoint,@checklistTecnicPoint,@checklistnfrastrucePoint ,@majorPoint,@infrastruceMajorPoint,@tecnicMajorpoint,@kaliteProcessPoint,@kaliteTecnicPoint,@kalitenfrastrucePoint)
end
	

 if(@auditChoseAction=2)
	begin
	update TblAuditRealize set TotalPoint=(@kaliteProcessPoint-@majorPoint), 
	AuditDate=GETDATE(),
	TotalProcessPoint=@kaliteProcessPoint,
	TotalInfraPoint=@checklistnfrastrucePoint,
	TotalTechPoint=@checklistTecnicPoint,
	QualityPoint=@kaliteProcessPoint,
	QualityTecnic=@kaliteTecnicPoint,
	QualityInfra=@kalitenfrastrucePoint,
	MajorPoint=@majorPoint,
	InfraMajorPoint=@infrastruceMajorPoint,
	TechMajorPoint=@tecnicMajorpoint 
	where AuditPlanID=@auditPlanID
	end
end
END
exec [dbo].SP_UpdateHandDeviceCalculatePoint @auditPlanID,@auditChoseAction,@auditType
exec [dbo].[SP_Average] @auditPlanID


-- exec SP_CalculateAuditPlanTotalPoint 48,1,NULL,NULL,8







GO
/****** Object:  StoredProcedure [dbo].[SP_CancelAuditRealized]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CancelAuditRealized]
	-- Add the parameters for the stored procedure here
	@auditPlanID int,
	@auditorID int
	-- exec SP_Average 30
	--select * from TblAuditPlan where AuditPlanID=30
	-- select * from TblAuditType
AS
BEGIN
declare @auditorCount int;
declare @auditedAuditorCount int;
declare @answerCount int

if  EXISTS (select AuditorID from TblAuditRealizeDetail where AuditPlanID= @auditPlanID and AuditorID=@auditorID) 
select @answerCount =count(QuestionID) from TblAuditRealizeDetail where AuditPlanID=@auditPlanID and AuditorID=@auditorID
select @auditedAuditorCount = AuditorCount from TblAuditPlan where AuditPlanID=@auditPlanID
select @auditorCount=   count(AuditorID) from TblAuditorAuditPlan where AuditPlanID=@auditPlanID


delete TblAuditRealize where AuditPlanID=@auditPlanID
delete TblAuditRealizeDetail where AuditPlanID=@auditPlanID
update TblAuditPlan set IsAudited=0,AuditorCount=(AuditorCount-1)


end
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETEAUDITPLAN]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SP_DELETEAUDITPLAN]
  @PlanID int

AS
BEGIN
	delete from TblAuditAreaPlan where AuditPlanID=@PlanID

	delete from [dbo].[TblHandAndDeviceCorrective] where AuditPlanID=@PlanID

	delete from [dbo].[TblAuditMeasurePlan] where AuditPlanID=@PlanID

	delete from TblAuditorAuditPlan where AuditPlanID=@PlanID

	delete from TblAuditedHands where AuditPlanID=@PlanID

	delete from TblAuditedDevice where AuditPlanID=@PlanID

	delete from TblAuditRealize where AuditPlanID=@PlanID

	delete from TblProviderAuditPlanInfo where AuditPlanID=@PlanID

	 delete from [dbo].[TblMinutesDetail] where AuditPlanID=@PlanID

	delete from TblAuditRealizeMeasureResult where AuditPlanID=@PlanID

	delete from TblAuditRealizeResponsible where AuditPlanID=@PlanID
	delete from img from  TblAuditRealizeImage as img
	inner join TblAuditRealizeDetail as aurede on img.AuditReDetID=aurede.AudReDetID
	where aurede.AuditPlanID=@PlanID

	delete from f from  TblFixedActivity as f
	inner join TblAuditRealizeDetail as aurede on f.AuditReDetID=aurede.AudReDetID
	where aurede.AuditPlanID=@PlanID

	delete from TblAuditRealizeDetail where  AuditPlanID=@PlanID

	delete from TblAuditPlan where AuditPlanID=@PlanID

END





GO
/****** Object:  StoredProcedure [dbo].[SP_DELETEAUDITPLANTRANSFER]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_DELETEAUDITPLANTRANSFER]
@PlanCode nvarchar(50)
AS
BEGIN
delete from area from  TblAuditAreaPlan as area
	inner join TblAuditPlan as ap on area.AuditPlanID=ap.AuditPlanID
	where ap.PlanName=@PlanCode

	
delete from meas from  TblAuditMeasurePlan as meas
	inner join TblAuditPlan as ap on meas.AuditPlanID=ap.AuditPlanID
	where ap.PlanName=@PlanCode


delete from au from  TblAuditorAuditPlan as au
	inner join TblAuditPlan as ap on au.AuditPlanID=ap.AuditPlanID
	where ap.PlanName=@PlanCode

	delete from au from  TblAuditRealizeMeasureResult as au
	inner join TblAuditPlan as ap on au.AuditPlanID=ap.AuditPlanID
	where ap.PlanName=@PlanCode

delete from TblAuditPlan where PlanName=@PlanCode
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAuditRealizeCorrectiveActivityList]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAuditRealizeCorrectiveActivityList] 
@Criteria nvarchar(4000)
AS 
BEGIN 
declare @sql varchar(6000)

	set @sql=
	'
	declare @true bit=1
    declare @false bit=0
	SELECT 
			auditPlan.AuditPlanID AS AuditPlanID,
			auditPlan.AuditDate AS AuditDate,
			auditType.TypeName AS AuditType,
			audit.AuditName AS Audit,
			location.LocationName AS ServiceName,
			--auditRealize.UnsuitabilityStatue AS UnsuitabilityStatue,			
			--case when (select count(*) from TblAuditRealizeDetail where AuditPlanID = auditPlan.AuditPlanID and ActionStatue =0 and IsRegulatoryActivity != 1)>0 then @false else @true end AS UnsuitabilityStatue,
			CASE WHEN (auditRealize.UnsuitabilityStatue IS NULL OR auditRealize.UnsuitabilityStatue=1) THEN @true ELSE @false END AS UnsuitabilityStatue,
			CASE WHEN (SELECT COUNT(*) FROM TblAuditRealizeDetail WHERE AuditPlanID = auditPlan.AuditPlanID AND IsRegulatoryActivity = 1 AND ConfirmActionStatue != 1)>0 then @true else @false end AS CorrectiveActivityStatue,
			CASE WHEN (SELECT dbo.FN_HandAndDeviceUnCorrectiveCount(auditPlan.AuditPlanID))>0 THEN @true ELSE @false END AS HandAndDevice
	FROM 
			   TblAuditRealize     AS auditRealize 
	INNER JOIN TblAuditPlan        AS auditPlan    on auditRealize.AuditPlanID = auditPlan.AuditPlanID
	INNER JOIN TblLocation         AS location     on auditPlan.LocationID = location.LocationID
	INNER JOIN TblAuditType        AS auditType    on auditPlan.AuditTypeID = auditType.AuditTypeID
	INNER JOIN TblAudit            AS audit        on auditPlan.AuditID = audit.AuditID
	INNER JOIN TblAuditorAuditPlan AS auditorplan  on auditPlan.AuditPlanID = auditorplan.AuditPlanID
	WHERE '+convert(varchar(4000),@Criteria)
	exec(@sql)
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetHandAndDeviceUnCorrectiveList]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_GetHandAndDeviceUnCorrectiveList]
@Criteria nvarchar(4000)
    
AS
BEGIN
declare @sql varchar(6000)
	set @sql=
	'
	DECLARE @true bit=1
	DECLARE @false bit=0
	SELECT 
	audit.AuditName as PlanName,
	auditPlan.AuditPlanID as AuditPlanID,
	auditPlan.AuditDate as AuditDate,
	auditType.TypeName as AuditType,
	location.LocationName as ServiceName,
	employe.EmployeeID as EmployeeID,
    --case when (select count(*) from TblAuditRealizeDetail where AuditPlanID = auditPlan.AuditPlanID and ActionStatue =0 and IsRegulatoryActivity != 1)>0 then @false else @true end AS UnsuitabilityStatue,
	CASE WHEN (auditRealize.UnsuitabilityStatue IS NULL OR auditRealize.UnsuitabilityStatue=1) THEN @true ELSE @false END AS UnsuitabilityStatue,
	CASE WHEN (SELECT COUNT(*) FROM TblAuditRealizeDetail WHERE AuditPlanID = auditPlan.AuditPlanID AND IsRegulatoryActivity = 1 AND ConfirmActionStatue != 1)>0 THEN @true ELSE @false END AS CorrectiveActivityStatue,
	CASE WHEN (SELECT dbo.FN_HandAndDeviceUnCorrectiveCount(auditPlan.AuditPlanID))>0 THEN @true ELSE @false END AS HandAndDevice
	
	FROM TblAuditRealize AS auditRealize
	
	INNER JOIN TblAuditPlan AS auditPlan ON  auditRealize.AuditPlanID = auditPlan.AuditPlanID
	INNER JOIN TblLocation AS location ON auditPlan.LocationID = location.LocationID
	INNER JOIN TblAuditType AS auditType ON auditPlan.AuditTypeID = auditType.AuditTypeID
	INNER JOIN TblAudit AS audit ON auditPlan.AuditID = audit.AuditID
	INNER JOIN TblEmployeeLocation AS emploc ON location.LocationID = emploc.LocationID
	INNER JOIN TblEmployee AS employe ON emploc.EmployeeID = employe.EmployeeID
	WHERE '+convert(varchar(4000),@Criteria)
	exec(@sql)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProviderAuditRealizeCorrectiveActivityList]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GetProviderAuditRealizeCorrectiveActivityList] 
@Criteria nvarchar(4000),
@SkipStep int,
@Take int
AS 
BEGIN 
declare @sql varchar(6000)

	set @sql=
	'
	declare @true bit=1
    declare @false bit=0
	SELECT 
			auditPlan.AuditPlanID AS AuditPlanID,
			auditPlan.AuditDate AS AuditDate,
			auditType.TypeName AS AuditType,
			audit.AuditName AS Audit,
			provider.Name AS ServiceName,
			CASE WHEN (auditRealize.UnsuitabilityStatue IS NULL OR auditRealize.UnsuitabilityStatue=1) THEN @true ELSE @false END AS UnsuitabilityStatue
			--CASE WHEN (SELECT COUNT(*) FROM TblAuditRealizeDetail WHERE AuditPlanID = auditPlan.AuditPlanID AND IsRegulatoryActivity = 1 AND ConfirmActionStatue != 1)>0 then @true else @false end AS CorrectiveActivityStatue,
			--CASE WHEN (SELECT dbo.FN_HandAndDeviceUnCorrectiveCount(auditPlan.AuditPlanID))>0 THEN @true ELSE @false END AS HandAndDevice
	FROM 
			   TblAuditRealize     AS auditRealize 
	INNER JOIN TblAuditPlan        AS auditPlan    on auditRealize.AuditPlanID = auditPlan.AuditPlanID
	INNER JOIN TblProvider         AS provider     on auditPlan.ProviderID = provider.ProviderID
	INNER JOIN TblAuditType        AS auditType    on auditPlan.AuditTypeID = auditType.AuditTypeID
	INNER JOIN TblAudit            AS audit        on auditPlan.AuditID = audit.AuditID
	INNER JOIN TblAuditorAuditPlan AS auditorplan  on auditPlan.AuditPlanID = auditorplan.AuditPlanID
	WHERE '+convert(varchar(4000),@Criteria) + +' ORDER BY auditRealize.AuditDate DESC  OFFSET  '+Convert(varchar,@SkipStep)+'  ROWS FETCH NEXT '+Convert(varchar,@Take)+' ROWS ONLY'
	exec(@sql)
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_HandAndDeviceCorrective]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_HandAndDeviceCorrective]
@AuditPlanID int
AS
declare
@HandPoint float,
@DevicePoint float,
@UpdateHandPoint float,
@UpdateDevicePoint float,
@HandAndDeviceText nvarchar(max),
@RecordCount int,
@AudReDeAccCount int,--Duzeltici Faaliyet
@ActionStatue bit,
@ConfirmActionStatue bit,
@AuditedDeviceID int

--Realize tablosunda kaytları hesapkıyoruz
select 
@HandPoint=  re.HandSamplePoint,
@DevicePoint=re.[ItemSamplePoint]
from TblAuditRealize as re where re.AuditPlanID=@AuditPlanID;

--Kayıt mevcut degilse ekleniyor yoksa guncelleniyor
select @RecordCount=count(AuditPlanID)
 from TblHandAndDeviceCorrective where AuditPlanID=@AuditPlanID;
 --Denetim ceklistte D.F kontrol amacli cekiliyor
select @AudReDeAccCount=count(AudReDetID) from TblAuditRealizeDetail where AuditPlanID=@AuditPlanID 
		and IsRegulatoryActivity=1 and ConfirmActionStatue=0;
if(@RecordCount=0)
begin
if	(@HandPoint is not null and @DevicePoint is not null) 
begin 
		if	(@HandPoint<10 and @DevicePoint <10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='HandAndDevice'
		insert into [dbo].[TblHandAndDeviceCorrective]( [AuditPlanID],[Explanation] ,[ActionStatue],[ConfirmStatue],[IsActive]) 
        values (@AuditPlanID,@HandAndDeviceText,0,0,1)
		if(@AudReDeAccCount=0)begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
		else if	(@HandPoint<10 and @DevicePoint=10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Hand'
		insert into [dbo].[TblHandAndDeviceCorrective]( [AuditPlanID],[Explanation] ,[ActionStatue],[ConfirmStatue],[IsActive]) 
        values (@AuditPlanID,@HandAndDeviceText,0,0,1)
		if(@AudReDeAccCount=0)begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
		else if	(@HandPoint=10 and @DevicePoint<10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Device'
		insert into [dbo].[TblHandAndDeviceCorrective]( [AuditPlanID],[Explanation] ,[ActionStatue],[ConfirmStatue],[IsActive]) 
        values (@AuditPlanID,@HandAndDeviceText,0,0,1)
		if(@AudReDeAccCount=0)begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
		
end
else if	(@HandPoint is null and @DevicePoint is not null) 
begin 
		if	( @DevicePoint <10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Device'
		select @AuditedDeviceID= AuditedDeviceID from TblAuditedDevice where AuditPlanID =@AuditPlanID
		insert into [dbo].[TblHandAndDeviceCorrective]( [AuditPlanID],[Explanation] ,[ActionStatue],[ConfirmStatue],[IsActive]) 
        values (@AuditPlanID,@HandAndDeviceText,0,0,1)
		if(@AudReDeAccCount=0)begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
		
end
else if	(@HandPoint is not null and @DevicePoint is  null) 
begin 
		if	( @HandPoint <10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Hand'		
		insert into [dbo].[TblHandAndDeviceCorrective]( [AuditPlanID],[Explanation] ,[ActionStatue],[ConfirmStatue],[IsActive]) 
        values (@AuditPlanID,@HandAndDeviceText,0,0,1)
		if(@AudReDeAccCount=0)begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
end
--Denetim el-arac sonucu 
end

else
begin
	select @ConfirmActionStatue=ConfirmStatue from TblHandAndDeviceCorrective where AuditPlanID=@AuditPlanID
if	(@HandPoint is not null and @DevicePoint is not null) 
begin 
		if	(@HandPoint<10 and @DevicePoint <10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='HandAndDevice'
		update [dbo].[TblHandAndDeviceCorrective] set [Explanation]=@HandAndDeviceText,[IsActive]=1 
		where AuditPlanID=@AuditPlanID
		
		if(@AudReDeAccCount=0 and @ConfirmActionStatue=1)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end

		end
		else if	(@HandPoint<10 and @DevicePoint=10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Hand'
		update [dbo].[TblHandAndDeviceCorrective] set [Explanation]=@HandAndDeviceText,[IsActive]=1 
		where AuditPlanID=@AuditPlanID
		
		if(@AudReDeAccCount=0 and @ConfirmActionStatue=1)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end

		end
		else if	(@HandPoint=10 and @DevicePoint<10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Device'
		update [dbo].[TblHandAndDeviceCorrective] set [Explanation]=@HandAndDeviceText,[IsActive]=1 
		where AuditPlanID=@AuditPlanID
		
		if(@AudReDeAccCount=0 and @ConfirmActionStatue=1)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end

		end
		else if	(@HandPoint=10 and @DevicePoint=10) 
		begin 
		update [dbo].[TblHandAndDeviceCorrective] set [IsActive]=0
		where AuditPlanID=@AuditPlanID
		if(@AudReDeAccCount=0)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
end
else if	(@HandPoint is null and @DevicePoint is not null) 
begin 
		if	( @DevicePoint <10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Device'
		update [dbo].[TblHandAndDeviceCorrective] set [Explanation]=@HandAndDeviceText,[IsActive]=1 
		where AuditPlanID=@AuditPlanID
		if(@AudReDeAccCount=0 and @ConfirmActionStatue=1)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
		else if	(@DevicePoint=10) 
		begin 
		update [dbo].[TblHandAndDeviceCorrective] set [IsActive]=0
		where AuditPlanID=@AuditPlanID
		if(@AudReDeAccCount=0)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
end
else if	(@HandPoint is not null and @DevicePoint is  null) 
begin 
		if	( @HandPoint <10) 
		begin 
		select @HandAndDeviceText= SettingValue from TblAppSetting where SettingCode='Hand'
		update [dbo].[TblHandAndDeviceCorrective] set [Explanation]=@HandAndDeviceText,[IsActive]=1 
		where AuditPlanID=@AuditPlanID

		if(@AudReDeAccCount=0 and @ConfirmActionStatue=1)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end

		end
		else if	(@HandPoint=10) 
		begin 
		update [dbo].[TblHandAndDeviceCorrective] set [IsActive]=0
		where AuditPlanID=@AuditPlanID
		if(@AudReDeAccCount=0)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
end
		else if	(@HandPoint is  null and @DevicePoint is  null) 
		begin 
		update [dbo].[TblHandAndDeviceCorrective] set [IsActive]=0
		where AuditPlanID=@AuditPlanID
		if(@AudReDeAccCount=0)
		begin update TblAuditRealize set CorrectiveActivityStatue=1 where AuditPlanID=@AuditPlanID end
		else 
		begin update TblAuditRealize set CorrectiveActivityStatue=0 where AuditPlanID=@AuditPlanID end
		end
end



GO
/****** Object:  StoredProcedure [dbo].[SP_InsertLocationPoint]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertLocationPoint]
AS
BEGIN
	BEGIN TRANSACTION 
	BEGIN TRY 
		CREATE TABLE #TEMP (				
		 LocationID	int,
         LocationName nvarchar(100),
         TypeDetailId int,
         TypeName nvarchar(130),
         YearID	int,
         MonthID int,
         auditPoint	float,
         CheckListPoint	float,
         QualityPoint float,
         handPoint float,
         devicePoint float,
         majorPoint	float,
         VirtualRegionID int,
         VirtualRegion nvarchar(100)
	)
	
	INSERT INTO #TEMP SELECT * FROM V_LocationPoint WITH (NOLOCK)

	TRUNCATE TABLE TblLocationPoint

	INSERT INTO TblLocationPoint SELECT * FROM #TEMP
				
	DROP TABLE #TEMP

	COMMIT 
	END TRY 
	BEGIN CATCH 
	ROLLBACK 
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LOCATION_POINTS]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create  PROCEDURE [dbo].[SP_LOCATION_POINTS] 
	@LocationID int
AS
BEGIN
select * from TblAuditRealizeDetail tard2 where
 tard2.AudReDetID in 
(
	select MAX(tard.AudReDetID) from  TblAuditRealizeDetail tard
	INNER JOIN TblAuditPlan tap on tap.AuditPlanID = tard.AuditPlanID
	where tap.LocationID = @LocationID 
	GROUP BY  tard.QuestionID
);
END


GO
/****** Object:  StoredProcedure [dbo].[SP_PublishLocationPoint]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





















/* 
Author : ERHAN ÇINAR
Date : 20.11.2021
Explanation : AYLIK HİJYEN DENETİM PUANI
*/

CREATE PROCEDURE [dbo].[SP_PublishLocationPoint]
AS
  BEGIN
  SET NOCOUNT ON;
  SET FMTONLY OFF;
  Declare @temp table(LocationID int,LocationName nvarchar(100),TypeDetailId int,TypeName nvarchar(100),YearID int,MonthID int,
auditPoint float,CheckListPoint float,QualityPoint float,handPoint float,devicePoint float,majorPoint float,VirtualRegionID int, VirtualRegion nvarchar(100));
insert into @temp(LocationID,LocationName,TypeDetailId,TypeName,YearID,MonthID,auditPoint,CheckListPoint,QualityPoint,handPoint,devicePoint,majorPoint,
VirtualRegionID,VirtualRegion)
SELECT DISTINCT 
V.LocationID,
L.LocationName,
TD.TypeDetailId,
TD.TypeName,
V.YearID,
V.MonthID,
V.auditPoint,
V.CheckListPoint,
V.QualityPoint,
V.handPoint,
V.devicePoint,
V.majorPoint,
VR.VirtualRegionID,
VR.Name as "VirtualRegion"
from [NetAuditDB].[dbo].[V_AvveragePublishLocationPoints] AS V WITH (NOLOCK)
INNER JOIN [NetAuditDB].[dbo].TblLocation AS L WITH (NOLOCK) ON L.LocationID= V.LocationID
INNER JOIN [NetAuditDB].[dbo].TblVirtualRegion AS VR WITH (NOLOCK) ON L.RegionID=VR.VirtualRegionID
INNER JOIN [NetAuditDB].[dbo].TblTypeDetail AS TD WITH (NOLOCK)  ON L.LocationTypeID = TD.TypeDetailId
Where V.YearID= YEAR(GETDATE()-15)

declare @temp2 table(ManagerName nvarchar(100),LocationID int,RoleName nvarchar(100));
insert into @temp2(ManagerName,LocationID,RoleName)
SELECT DISTINCT 
MOL.Name +' ' + MOL.Surname AS ManagerName,
MOL.LocationID,
MOL.RoleName
from [dbo].V_ManagerOfLocations AS MOL WITH (NOLOCK) 


select 
temp.LocationID,
temp.LocationName,
temp.TypeDetailId,
temp.TypeName,
temp.YearID,
temp.MonthID,
temp.auditPoint,
temp.CheckListPoint,
temp.QualityPoint,
temp.handPoint,
temp.devicePoint,
temp.majorPoint,
temp.VirtualRegionID,
temp.VirtualRegion,
temp2.ManagerName,
temp2.RoleName
from @temp as temp

left join @temp2 as temp2 on temp.LocationID=temp2.LocationID

 END




GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERLOG]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SP_TRANSFERLOG]

AS
BEGIN

--Master log tablo bilgisi aktariliyor. Burda primarykey kaldirilmis 
INSERT INTO NETAUDITDBLOG.dbo.AuditEntries
(AuditEntryID, EntitySetName,EntityPrimaryKey,State,StateName,CreatedByID,CreatedBy,CreatedDate,ComputerIP)
SELECT  AuditEntryID,EntitySetName,EntityPrimaryKey,State,StateName,CreatedByID,CreatedBy,CreatedDate,ComputerIP
FROM    AuditEntries 
--Aktarma isleminden sonra master toblosunda bulanan kayitlari siliyoruz.

--Alt log tablo bilgisi aktariliyor. Primary key kaldirilmis.
INSERT INTO NETAUDITDBLOG.dbo.AuditEntryProperties
(AuditEntryPropertyID,AuditEntryID,NewValue,OldValue,PropertyName)
SELECT  AuditEntryPropertyID,AuditEntryID,NewValue,OldValue,PropertyName
FROM    AuditEntryProperties 
--Aktarma isleminden sonra aşt log toblosunda bulanan kayitlari siliyoruz.
delete from dbo.AuditEntryProperties 
delete from dbo.AuditEntries 

END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateHandDeviceCalculatePoint]    Script Date: 30.05.2024 17:22:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_UpdateHandDeviceCalculatePoint]
@auditPlanID int,
@auditChoseAction int,
@auditType int
AS
Begin
if(@auditChoseAction=2 and @auditType=0)
begin
declare
@updateHandPoint float,
@updateDevicePoint float
	select @updateHandPoint=  HandSamplePoint from TblAuditRealize where AuditPlanID=@auditPlanID;
	select @updateDevicePoint=  ItemSamplePoint from TblAuditRealize where AuditPlanID=@auditPlanID;
	if(@updateHandPoint is not null and @updateDevicePoint is not null)
	begin
	update TblAuditRealize set TotalPoint=(((TotalProcessPoint*0.8+((@updateHandPoint+@updateDevicePoint)*100/20)*0.2)-MajorPoint)*0.8+QualityPoint*0.2),
	ResultTecnicPoint=(((ProcesTecnicPoint*0.8+((@updateHandPoint+@updateDevicePoint)*100/20)*0.2)-TechMajorPoint)*0.8+QualityProTecnic*0.2),
	ResultInfraPoint=(((ProcesInfraPoint*0.8+((@updateHandPoint+@updateDevicePoint)*100/20)*0.2)-InfraMajorPoint)*0.8+QualityProInfra*0.2)
	where AuditPlanID=@auditPlanID
	end
	else if(@updateHandPoint is not null and @updateDevicePoint is  null)
	begin
	update TblAuditRealize set TotalPoint=(((TotalProcessPoint*0.9+((@updateHandPoint)*100/10)*0.1)-MajorPoint)*0.8+QualityPoint*0.2),
		ResultTecnicPoint=(((ProcesTecnicPoint*0.9+((@updateHandPoint)*100/10)*0.1)-TechMajorPoint)*0.8+QualityProTecnic*0.2),
	ResultInfraPoint=(((ProcesInfraPoint*0.9+((@updateHandPoint)*100/10)*0.1)-InfraMajorPoint)*0.8+QualityProInfra*0.2)
	 where AuditPlanID=@auditPlanID
	end
	else if(@updateHandPoint is  null and @updateDevicePoint is not null)
	begin
	update TblAuditRealize set TotalPoint=(((TotalProcessPoint*0.9+((@updateDevicePoint)*100/10)*0.1)-MajorPoint)*0.8+QualityPoint*0.2),
	ResultTecnicPoint=(((ProcesTecnicPoint*0.9+((@updateDevicePoint)*100/10)*0.1)-TechMajorPoint)*0.8+QualityProTecnic*0.2),
	ResultInfraPoint=(((ProcesInfraPoint*0.9+((@updateDevicePoint)*100/10)*0.1)-InfraMajorPoint)*0.8+QualityProInfra*0.2)
	 where AuditPlanID=@auditPlanID
	end
	end
end

GO
EXEC sys.sp_addextendedproperty @name=N'Açıklama', @value=N'HKY Müdürleri ile denetçiler arasındaki ilişkiyi temsil eder' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployeeRelationship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "lo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "typede"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 136
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "grlo"
            Begin Extent = 
               Top = 6
               Left = 456
               Bottom = 119
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gr"
            Begin Extent = 
               Top = 120
               Left = 456
               Bottom = 250
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pe"
            Begin Extent = 
               Top = 120
               Left = 664
               Bottom = 250
               Right = 834
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "co"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "qt"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 251
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditPlanExcelData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       End
         Begin Table = "qs"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 365
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditPlanExcelData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditPlanExcelData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 292
               Bottom = 136
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 500
               Bottom = 136
               Right = 689
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 727
               Bottom = 136
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "typd"
            Begin Extent = 
               Top = 138
               Left = 247
               Bottom = 268
               Right = 417
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "au"
            Begin Extent = 
               Top = 138
               Left = 455
               Bottom = 268
               Right = 680
            End
            DisplayFlags = 280
            TopColumn = 0
         End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditRealizeHandAndDevice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Begin Table = "a"
            Begin Extent = 
               Top = 138
               Left = 718
               Bottom = 268
               Right = 889
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "empp"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 382
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "poz"
            Begin Extent = 
               Top = 270
               Left = 246
               Bottom = 400
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rede"
            Begin Extent = 
               Top = 270
               Left = 454
               Bottom = 400
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "levelDe"
            Begin Extent = 
               Top = 270
               Left = 693
               Bottom = 400
               Right = 863
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "regulation"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mgroup"
            Begin Extent = 
               Top = 402
               Left = 286
               Bottom = 532
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditRealizeHandAndDevice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditRealizeHandAndDevice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 292
               Bottom = 136
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 500
               Bottom = 136
               Right = 689
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 727
               Bottom = 136
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "typd"
            Begin Extent = 
               Top = 138
               Left = 247
               Bottom = 268
               Right = 417
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "au"
            Begin Extent = 
               Top = 138
               Left = 455
               Bottom = 268
               Right = 680
            End
            DisplayFlags = 280
            TopColumn = 0
         End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditRealizeMajor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Begin Table = "a"
            Begin Extent = 
               Top = 138
               Left = 718
               Bottom = 268
               Right = 889
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "empp"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 382
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "poz"
            Begin Extent = 
               Top = 270
               Left = 246
               Bottom = 400
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditRealizeMajor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AuditRealizeMajor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "emp"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emplo"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lo"
            Begin Extent = 
               Top = 6
               Left = 456
               Bottom = 136
               Right = 628
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rol"
            Begin Extent = 
               Top = 6
               Left = 666
               Bottom = 136
               Right = 836
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "typede"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GetResponsibleLocationInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GetResponsibleLocationInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GetResponsibleLocationInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_LocationAverageAuditPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_LocationAverageAuditPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "me"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "subme"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "meitemre"
            Begin Extent = 
               Top = 6
               Left = 456
               Bottom = 119
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "item"
            Begin Extent = 
               Top = 6
               Left = 669
               Bottom = 136
               Right = 844
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rolitem"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 233
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_MenuInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_MenuInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_MenuInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "usmess"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "us"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 136
               Right = 483
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp"
            Begin Extent = 
               Top = 6
               Left = 521
               Bottom = 136
               Right = 707
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "con"
            Begin Extent = 
               Top = 6
               Left = 745
               Bottom = 136
               Right = 931
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_NotificationAutimaticEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_NotificationAutimaticEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "risktableloc"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "risktable"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 136
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "procstep"
            Begin Extent = 
               Top = 6
               Left = 524
               Bottom = 136
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dangersource"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dangerstatus"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 268
               Right = 427
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "risk"
            Begin Extent = 
               Top = 138
               Left = 465
               Bottom = 268
               Right = 646
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pereffct"
            Begin Extent = 
               Top = 138
               Left = 684
               Bottom = 268
               Right = 854
            End
            Disp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_OHSRiskAssmentTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'layFlags = 280
            TopColumn = 0
         End
         Begin Table = "docrelation"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 383
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "doc"
            Begin Extent = 
               Top = 270
               Left = 293
               Bottom = 383
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "preriskre"
            Begin Extent = 
               Top = 270
               Left = 561
               Bottom = 383
               Right = 763
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "contpre"
            Begin Extent = 
               Top = 384
               Left = 38
               Bottom = 514
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_OHSRiskAssmentTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_OHSRiskAssmentTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ty"
            Begin Extent = 
               Top = 6
               Left = 269
               Bottom = 136
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ttype"
            Begin Extent = 
               Top = 6
               Left = 477
               Bottom = 119
               Right = 658
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "emp"
            Begin Extent = 
               Top = 6
               Left = 696
               Bottom = 136
               Right = 866
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dep"
            Begin Extent = 
               Top = 120
               Left = 477
               Bottom = 250
               Right = 661
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "loc"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_TargetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_TargetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_TargetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "realize"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pl"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 136
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
USE [master]
GO
ALTER DATABASE [SARDUNYADBNEW] SET  READ_WRITE 
GO
