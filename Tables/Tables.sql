USE [master]
GO
/****** Object:  Database [440Project]    Script Date: 5/2/2016 10:29:07 AM ******/
CREATE DATABASE [440Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'440Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\440Project.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'440Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\440Project_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [440Project] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [440Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [440Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [440Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [440Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [440Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [440Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [440Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [440Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [440Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [440Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [440Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [440Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [440Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [440Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [440Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [440Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [440Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [440Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [440Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [440Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [440Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [440Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [440Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [440Project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [440Project] SET  MULTI_USER 
GO
ALTER DATABASE [440Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [440Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [440Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [440Project] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [440Project] SET DELAYED_DURABILITY = DISABLED 
GO
USE [440Project]
GO
/****** Object:  Table [dbo].[branch]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[branch](
	[release_id] [int] NOT NULL,
	[URL] [varchar](100) NOT NULL,
 CONSTRAINT [PK_branch] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[city]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[city](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [nvarchar](20) NOT NULL,
	[zipcode] [nchar](20) NULL,
	[country_id] [int] NOT NULL,
	[state_id] [int] NULL,
 CONSTRAINT [PK_city] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[company]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[company_address]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_address](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[street] [nvarchar](30) NOT NULL,
	[street1] [nvarchar](30) NULL,
	[company_id] [int] NOT NULL,
	[city_id] [int] NOT NULL,
 CONSTRAINT [PK_company_address] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[company_product]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_product](
	[product_id] [int] NOT NULL,
	[company_id] [smallint] NOT NULL,
 CONSTRAINT [PK_company_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[country]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_first_name] [nvarchar](20) NOT NULL,
	[customer_last_name] [nvarchar](30) NOT NULL,
	[company_id] [int] NOT NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[customer_release]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_release](
	[release_id] [int] NOT NULL,
	[release_option] [smallint] NOT NULL,
	[product_id] [int] NOT NULL,
	[release_date] [date] NOT NULL,
 CONSTRAINT [PK_customer_release] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[development_release]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[development_release](
	[iteration_id] [int] IDENTITY(1,1) NOT NULL,
	[start_date] [date] NOT NULL,
	[finish_date] [date] NOT NULL,
	[product_id] [int] NOT NULL,
	[release_id] [int] NULL,
 CONSTRAINT [PK_development_release] PRIMARY KEY CLUSTERED 
(
	[iteration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[development_release_feature]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[development_release_feature](
	[iteration_id] [int] NOT NULL,
	[feature_id] [int] NOT NULL,
 CONSTRAINT [PK_development_release_feature] PRIMARY KEY CLUSTERED 
(
	[iteration_id] ASC,
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[download]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[download](
	[customer_id] [int] NOT NULL,
	[download_date] [date] NOT NULL,
	[product_version] [varchar](15) NOT NULL,
	[release_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
 CONSTRAINT [PK_download] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC,
	[download_date] ASC,
	[product_version] ASC,
	[release_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[email]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[email](
	[customer_id] [int] NOT NULL,
	[email_address] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_email] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[feature]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[feature](
	[feature_id] [int] IDENTITY(1,1) NOT NULL,
	[feature_name] [varchar](100) NOT NULL,
	[feature_description] [varchar](250) NOT NULL,
	[platform_id] [smallint] NOT NULL,
 CONSTRAINT [PK_feature] PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[phone]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phone](
	[phone_id] [int] IDENTITY(1,1) NOT NULL,
	[phone_number] [nchar](20) NOT NULL,
	[phone_type_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
 CONSTRAINT [PK_phone] PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[phone_type]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[phone_type](
	[phone_type_id] [int] IDENTITY(1,1) NOT NULL,
	[phone_type] [varchar](10) NOT NULL,
 CONSTRAINT [PK_phone_status] PRIMARY KEY CLUSTERED 
(
	[phone_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[platform_type]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[platform_type](
	[platform_id] [smallint] IDENTITY(1,1) NOT NULL,
	[platform] [varchar](50) NOT NULL,
 CONSTRAINT [PK_platform_type] PRIMARY KEY CLUSTERED 
(
	[platform_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_description] [varchar](250) NOT NULL,
	[product_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[release_option]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[release_option](
	[release_option] [smallint] NOT NULL,
	[release_status] [varchar](25) NOT NULL,
 CONSTRAINT [PK_release_option] PRIMARY KEY CLUSTERED 
(
	[release_option] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[release_version]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[release_version](
	[release_id] [int] IDENTITY(1,1) NOT NULL,
	[product_version] [varchar](15) NOT NULL,
	[platform] [varchar](15) NOT NULL,
	[release_name] [varchar](15) NOT NULL,
 CONSTRAINT [PK_version] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[state]    Script Date: 5/2/2016 10:29:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[state](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[state_name] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_state] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[city]  WITH CHECK ADD  CONSTRAINT [FK_city_country] FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([country_id])
GO
ALTER TABLE [dbo].[city] CHECK CONSTRAINT [FK_city_country]
GO
ALTER TABLE [dbo].[city]  WITH CHECK ADD  CONSTRAINT [FK_city_state] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO
ALTER TABLE [dbo].[city] CHECK CONSTRAINT [FK_city_state]
GO
ALTER TABLE [dbo].[company_address]  WITH CHECK ADD  CONSTRAINT [FK_company_address_city] FOREIGN KEY([city_id])
REFERENCES [dbo].[city] ([city_id])
GO
ALTER TABLE [dbo].[company_address] CHECK CONSTRAINT [FK_company_address_city]
GO
ALTER TABLE [dbo].[company_address]  WITH CHECK ADD  CONSTRAINT [FK_company_address_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[company_address] CHECK CONSTRAINT [FK_company_address_company]
GO
ALTER TABLE [dbo].[company_product]  WITH CHECK ADD  CONSTRAINT [FK_company_product_company] FOREIGN KEY([product_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[company_product] CHECK CONSTRAINT [FK_company_product_company]
GO
ALTER TABLE [dbo].[company_product]  WITH CHECK ADD  CONSTRAINT [FK_company_product_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[company_product] CHECK CONSTRAINT [FK_company_product_product]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FK_customer_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FK_customer_company]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FK_customer_email] FOREIGN KEY([customer_id])
REFERENCES [dbo].[email] ([customer_id])
GO
ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FK_customer_email]
GO
ALTER TABLE [dbo].[customer_release]  WITH CHECK ADD  CONSTRAINT [FK_customer_release_branch] FOREIGN KEY([release_id])
REFERENCES [dbo].[branch] ([release_id])
GO
ALTER TABLE [dbo].[customer_release] CHECK CONSTRAINT [FK_customer_release_branch]
GO
ALTER TABLE [dbo].[customer_release]  WITH CHECK ADD  CONSTRAINT [FK_customer_release_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[customer_release] CHECK CONSTRAINT [FK_customer_release_product]
GO
ALTER TABLE [dbo].[customer_release]  WITH CHECK ADD  CONSTRAINT [FK_customer_release_release_option] FOREIGN KEY([release_option])
REFERENCES [dbo].[release_option] ([release_option])
GO
ALTER TABLE [dbo].[customer_release] CHECK CONSTRAINT [FK_customer_release_release_option]
GO
ALTER TABLE [dbo].[development_release]  WITH CHECK ADD  CONSTRAINT [FK_development_release_customer_release] FOREIGN KEY([release_id])
REFERENCES [dbo].[customer_release] ([release_id])
GO
ALTER TABLE [dbo].[development_release] CHECK CONSTRAINT [FK_development_release_customer_release]
GO
ALTER TABLE [dbo].[development_release]  WITH CHECK ADD  CONSTRAINT [FK_development_release_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[development_release] CHECK CONSTRAINT [FK_development_release_product]
GO
ALTER TABLE [dbo].[development_release_feature]  WITH CHECK ADD  CONSTRAINT [FK_development_release_feature_development_release] FOREIGN KEY([iteration_id])
REFERENCES [dbo].[development_release] ([iteration_id])
GO
ALTER TABLE [dbo].[development_release_feature] CHECK CONSTRAINT [FK_development_release_feature_development_release]
GO
ALTER TABLE [dbo].[development_release_feature]  WITH CHECK ADD  CONSTRAINT [FK_development_release_feature_feature] FOREIGN KEY([feature_id])
REFERENCES [dbo].[feature] ([feature_id])
GO
ALTER TABLE [dbo].[development_release_feature] CHECK CONSTRAINT [FK_development_release_feature_feature]
GO
ALTER TABLE [dbo].[download]  WITH CHECK ADD  CONSTRAINT [FK_download_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_customer]
GO
ALTER TABLE [dbo].[download]  WITH CHECK ADD  CONSTRAINT [FK_download_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_product]
GO
ALTER TABLE [dbo].[download]  WITH CHECK ADD  CONSTRAINT [FK_download_version] FOREIGN KEY([release_id])
REFERENCES [dbo].[release_version] ([release_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_version]
GO
ALTER TABLE [dbo].[feature]  WITH CHECK ADD  CONSTRAINT [FK_feature_platform_type] FOREIGN KEY([platform_id])
REFERENCES [dbo].[platform_type] ([platform_id])
GO
ALTER TABLE [dbo].[feature] CHECK CONSTRAINT [FK_feature_platform_type]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_customer]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_phone_type] FOREIGN KEY([phone_type_id])
REFERENCES [dbo].[phone_type] ([phone_type_id])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_phone_type]
GO
ALTER TABLE [dbo].[release_version]  WITH CHECK ADD  CONSTRAINT [FK_release_version_customer_release] FOREIGN KEY([release_id])
REFERENCES [dbo].[customer_release] ([release_id])
GO
ALTER TABLE [dbo].[release_version] CHECK CONSTRAINT [FK_release_version_customer_release]
GO

