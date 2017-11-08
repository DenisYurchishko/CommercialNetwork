USE master;

BEGIN --#region Database creation

	IF DB_ID('CommercialNetwork') IS NOT NULL
	BEGIN
	 DROP DATABASE CommercialNetwork;
	END

	CREATE DATABASE CommercialNetwork;

END --#endregion Database creation

USE CommercialNetwork;
GO

BEGIN --#region Tables creation

	BEGIN --#region Shop

		IF OBJECT_ID(N'Shop','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Shop];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Shop]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Name] NVARCHAR(255) NOT NULL,
			[Address] NVARCHAR(255) NOT NULL

			CONSTRAINT [PK_Shop] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

	END --#endregion Shop

	BEGIN --#region User

		IF OBJECT_ID(N'User','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[User];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[User]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Name] NVARCHAR(255) NOT NULL,
			[Login] NVARCHAR(255) NOT NULL,
			[Password] NVARCHAR(255) NOT NULL,
			[Role] NVARCHAR(255) NOT NULL,
			[Discount] INT NULL

			CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

	END --#endregion User

	BEGIN --#region Personal

		IF OBJECT_ID(N'Personal','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Personal];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Personal]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Name] NVARCHAR(255) NOT NULL,
			[Position] NVARCHAR(255) NOT NULL,
			[Salary] DECIMAL(18, 3) NOT NULL

			CONSTRAINT [PK_Personal] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

	END --#endregion Personal

	BEGIN --#region Provider

		IF OBJECT_ID(N'Provider','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Provider];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Provider]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Name] NVARCHAR(255) NOT NULL,
			[Address] NVARCHAR(255) NOT NULL

			CONSTRAINT [PK_Provider] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

	END --#endregion Provider

	BEGIN --#region ProductType

		IF OBJECT_ID(N'ProductType','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[ProductType];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[ProductType]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Name] NVARCHAR(255) NOT NULL,
			[ExpirationDate] DATETIME NULL

			CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

	END --#endregion ProductType

	BEGIN --#region Supply

		IF OBJECT_ID(N'Supply','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Supply];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Supply]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[ProviderId] INT NOT NULL,
			[SupplyDate] DATETIME NULL

			CONSTRAINT [PK_Supply] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[Supply]  WITH CHECK ADD  CONSTRAINT [FK_Provider_Supply] FOREIGN KEY([ProviderId])
			REFERENCES [dbo].[Provider] ([Id])
		ALTER TABLE [dbo].[Supply] CHECK CONSTRAINT [FK_Provider_Supply]

	END --#endregion Supply

	BEGIN --#region Product

		IF OBJECT_ID(N'Product','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Product];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Product]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Name] NVARCHAR(255) NOT NULL,
			[Quantity] DECIMAL(18, 3) NOT NULL,
			[Price] DECIMAL(18, 3) NOT NULL,
			[ShopId] INT NOT NULL,
			[ProductTypeId] INT NOT NULL

			CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Shop_Product] FOREIGN KEY([ShopId])
			REFERENCES [dbo].[Shop] ([Id])
		ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Shop_Product]

		ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_ProductType_Product] FOREIGN KEY([ProductTypeId])
			REFERENCES [dbo].[ProductType] ([Id])
		ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_ProductType_Product]

	END --#endregion Product

	BEGIN --#region ProductInSupply

		IF OBJECT_ID(N'ProductInSupply','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[ProductInSupply];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[ProductInSupply]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Quantity] DECIMAL(18, 3) NOT NULL,
			[NewPrice] DECIMAL(18, 3) NULL,
			[SupplyId] INT NOT NULL,
			[ProductId] INT NOT NULL

			CONSTRAINT [PK_ProductInSupply] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[ProductInSupply]  WITH CHECK ADD  CONSTRAINT [FK_Supply_ProductInSupply] FOREIGN KEY([SupplyId])
			REFERENCES [dbo].[Supply] ([Id])
		ALTER TABLE [dbo].[ProductInSupply] CHECK CONSTRAINT [FK_Supply_ProductInSupply]

		ALTER TABLE [dbo].[ProductInSupply]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductInSupply] FOREIGN KEY([ProductId])
			REFERENCES [dbo].[Product] ([Id])
		ALTER TABLE [dbo].[ProductInSupply] CHECK CONSTRAINT [FK_Product_ProductInSupply]

	END --#endregion ProductInSupply

	BEGIN --#region WorkingShift

		IF OBJECT_ID(N'WorkingShift','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[WorkingShift];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[WorkingShift]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[DateStart] DATETIME NOT NULL,
			[DateEnd] DATETIME NOT NULL,
			[ShopId] INT NOT NULL

			CONSTRAINT [PK_WorkingShift] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[WorkingShift]  WITH CHECK ADD  CONSTRAINT [FK_Shop_WorkingShift] FOREIGN KEY([ShopId])
			REFERENCES [dbo].[Shop] ([Id])
		ALTER TABLE [dbo].[WorkingShift] CHECK CONSTRAINT [FK_Shop_WorkingShift]

	END --#endregion WorkingShift

	BEGIN --#region PersonalInWorkingShift

		IF OBJECT_ID(N'PersonalInWorkingShift','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[PersonalInWorkingShift];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[PersonalInWorkingShift]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[CashDeskNumber] DECIMAL(18, 3) NULL,
			[PersonalId] INT NOT NULL,
			[WorkingShiftId] INT NOT NULL

			CONSTRAINT [PK_PersonalInWorkingShift] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[PersonalInWorkingShift]  WITH CHECK ADD  CONSTRAINT [FK_Personal_PersonalInWorkingShift] FOREIGN KEY([PersonalId])
			REFERENCES [dbo].[Personal] ([Id])
		ALTER TABLE [dbo].[PersonalInWorkingShift] CHECK CONSTRAINT [FK_Personal_PersonalInWorkingShift]

		ALTER TABLE [dbo].[PersonalInWorkingShift]  WITH CHECK ADD  CONSTRAINT [FK_WorkingShift_PersonalInWorkingShift] FOREIGN KEY([WorkingShiftId])
			REFERENCES [dbo].[WorkingShift] ([Id])
		ALTER TABLE [dbo].[PersonalInWorkingShift] CHECK CONSTRAINT [FK_WorkingShift_PersonalInWorkingShift]

	END --#endregion PersonalInWorkingShift

	BEGIN --#region Order

		IF OBJECT_ID(N'Order','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Order];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Order]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Status] NVARCHAR(255) NOT NULL,
			[Date] DATETIME NOT NULL,
			[Price] DECIMAL(18, 3) NOT NULL,
			[PersonalInWorkingShiftId] INT NOT NULL,
			[UserId] INT NOT NULL

			CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_PersonalInWorkingShift_Order] FOREIGN KEY([PersonalInWorkingShiftId])
			REFERENCES [dbo].[PersonalInWorkingShift] ([Id])
		ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_PersonalInWorkingShift_Order]

		ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_User_Order] FOREIGN KEY([UserId])
			REFERENCES [dbo].[User] ([Id])
		ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_PersonalInWorkingShift_Order]

	END --#endregion Order

	BEGIN --#region ProductInOrder

		IF OBJECT_ID(N'ProductInOrder','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[ProductInOrder];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[ProductInOrder]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Quantity] DECIMAL(18, 3) NOT NULL,
			[OrderId] INT NOT NULL,
			[ProductId] INT NOT NULL

			CONSTRAINT [PK_ProductInOrder] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[ProductInOrder]  WITH CHECK ADD  CONSTRAINT [FK_Order_ProductInOrder] FOREIGN KEY([OrderId])
			REFERENCES [dbo].[Order] ([Id])
		ALTER TABLE [dbo].[ProductInOrder] CHECK CONSTRAINT [FK_Order_ProductInOrder]

		ALTER TABLE [dbo].[ProductInOrder]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductInOrder] FOREIGN KEY([ProductId])
			REFERENCES [dbo].[Product] ([Id])
		ALTER TABLE [dbo].[ProductInOrder] CHECK CONSTRAINT [FK_Product_ProductInOrder]

	END --#endregion ProductInOrder

	BEGIN --#region Check

		IF OBJECT_ID(N'Check','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[Check];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[Check]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Date] DATETIME NOT NULL,
			[Type] NVARCHAR(100) NOT NULL,
			[OrderId] INT NOT NULL

			CONSTRAINT [PK_Check] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON,
				    ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[Check]  WITH CHECK ADD  CONSTRAINT [FK_Order_Check] FOREIGN KEY([OrderId])
			REFERENCES [dbo].[Order] ([Id])
		ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Order_Check]

	END --#endregion Order

END --#endregion Tables creation