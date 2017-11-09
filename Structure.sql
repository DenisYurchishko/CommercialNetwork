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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			[Email] NVARCHAR(255) NOT NULL,
			[Role] NVARCHAR(255) NOT NULL,
			[Discount] INT NULL

			CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			[Salary] DECIMAL(18, 3) NOT NULL,
			[Premium] DECIMAL(18, 3) NULL

			CONSTRAINT [PK_Personal] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			[SupplyDate] DATETIME NULL,
			[ProviderId] INT NOT NULL,
			[ShopId] INT NOT NULL,
			
			CONSTRAINT [PK_Supply] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[Supply]  WITH CHECK ADD  CONSTRAINT [FK_Provider_Supply] FOREIGN KEY([ProviderId])
			REFERENCES [dbo].[Provider] ([Id])
		ALTER TABLE [dbo].[Supply] CHECK CONSTRAINT [FK_Provider_Supply]
		
		ALTER TABLE [dbo].[Supply]  WITH CHECK ADD  CONSTRAINT [FK_Shop_Supply] FOREIGN KEY([ShopId])
			REFERENCES [dbo].[Shop] ([Id])
		ALTER TABLE [dbo].[Supply] CHECK CONSTRAINT [FK_Shop_Supply]

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
			[ProductTypeId] INT NOT NULL

			CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[ProductInSupply]  WITH CHECK ADD  CONSTRAINT [FK_Supply_ProductInSupply] FOREIGN KEY([SupplyId])
			REFERENCES [dbo].[Supply] ([Id])
		ALTER TABLE [dbo].[ProductInSupply] CHECK CONSTRAINT [FK_Supply_ProductInSupply]

		ALTER TABLE [dbo].[ProductInSupply]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductInSupply] FOREIGN KEY([ProductId])
			REFERENCES [dbo].[Product] ([Id])
		ALTER TABLE [dbo].[ProductInSupply] CHECK CONSTRAINT [FK_Product_ProductInSupply]

	END --#endregion ProductInSupply

	BEGIN --#region ProductInShop

		IF OBJECT_ID(N'ProductInShop','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[ProductInShop];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[ProductInShop]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[Quantity] DECIMAL(18, 3) NOT NULL,
			[Price] DECIMAL(18, 3) NULL,
			[ShopId] INT NOT NULL,
			[ProductId] INT NOT NULL

			CONSTRAINT [PK_ProductInShop] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[ProductInShop]  WITH CHECK ADD  CONSTRAINT [FK_Shop_ProductInShop] FOREIGN KEY([ShopId])
			REFERENCES [dbo].[Supply] ([Id])
		ALTER TABLE [dbo].[ProductInShop] CHECK CONSTRAINT [FK_Shop_ProductInShop]

		ALTER TABLE [dbo].[ProductInShop]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductInShop] FOREIGN KEY([ProductId])
			REFERENCES [dbo].[Product] ([Id])
		ALTER TABLE [dbo].[ProductInShop] CHECK CONSTRAINT [FK_Product_ProductInShop]

	END --#endregion ProductInShop
	
	BEGIN --#region NeedToSupply

		IF OBJECT_ID(N'NeedToSupply','U') IS NOT NULL
		BEGIN
			DROP TABLE [dbo].[NeedToSupply];
		END

		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		SET ANSI_PADDING ON

		CREATE TABLE [dbo].[NeedToSupply]
		(
			[Id] INT IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
			[ShopId] INT NOT NULL,
			[ProductId] INT NOT NULL

			CONSTRAINT [PK_NeedToSupply] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[NeedToSupply]  WITH CHECK ADD  CONSTRAINT [FK_Shop_NeedToSupply] FOREIGN KEY([ShopId])
			REFERENCES [dbo].[Supply] ([Id])
		ALTER TABLE [dbo].[NeedToSupply] CHECK CONSTRAINT [FK_Shop_NeedToSupply]

		ALTER TABLE [dbo].[NeedToSupply]  WITH CHECK ADD  CONSTRAINT [FK_Product_NeedToSupply] FOREIGN KEY([ProductId])
			REFERENCES [dbo].[Product] ([Id])
		ALTER TABLE [dbo].[NeedToSupply] CHECK CONSTRAINT [FK_Product_NeedToSupply]

	END --#endregion NeedToSupply

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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
			) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
				    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[Check]  WITH CHECK ADD  CONSTRAINT [FK_Order_Check] FOREIGN KEY([OrderId])
			REFERENCES [dbo].[Order] ([Id])
		ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Order_Check]

	END --#endregion Order

END --#endregion Tables creation

BEGIN --#region Tables insert initialize data

	BEGIN --#region ShopInsert
		
		INSERT INTO [dbo].[Shop]
			([Name], [Address])
		VALUES
			('Дионис №1', 'Ул. Молодёжная 1'),
			('Дионис №2', 'Ул. Молодёжная 2'),
			('Дионис №3', 'Ул. Молодёжная 3');
		
	END --#endregion ShopInsert
	
	BEGIN --#region PersonalInsert
		
		INSERT INTO [dbo].[Personal]
			([Name], [Position], [Salary])
		VALUES
			('Коврик Василий Иванович', 'Продавец', 3600),
			('Орех Алина Васильевна', 'Продавец', 1200),
			('Кивок Афанасий Владимирович', 'Продавец', 2600);
		
	END --#endregion PersonalInsert
	
	BEGIN --#region ProviderInsert
		
		INSERT INTO [dbo].[Provider]
			([Name], [Address])
		VALUES
			('ИП Ломачинский', 'Ул. Молодёжная 10'),
			('ООО Брусничка', 'Ул. Молодёжная 20'),
			('ООО Домовой', 'Ул. Молодёжная 30');
		
	END --#endregion ProviderInsert
	
	BEGIN --#region ProductTypeInsert
		
		INSERT INTO [dbo].[ProductType]
			([Name], [ExpirationDate])
		VALUES
			('Мясное', '2018/02/03'),
			('Молочное', '2018/02/02'),
			('Алкоголь', '2020/04/02');
		
	END --#endregion ProductTypeInsert
	
	BEGIN --#region ProductInsert
		
		INSERT INTO [dbo].[Product]
			([Name], [ProductTypeId])
		VALUES
			('Мясо', 1),
			('Молоко', 2),
			('Пиво', 3);
		
	END --#endregion ProductInsert

END --#endregion Tables Tables insert initialize data
GO
--#region Triggers
	
	--#region Shop Triggers

		IF OBJECT_ID(N'Trigger_Cascade_Delete_Shop') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_Shop;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_Shop
		ON [dbo].[Shop] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[Supply]
			WHERE
				[ShopId] IN (@OldId);
			
			DELETE
			FROM
				[dbo].[ProductInShop]
			WHERE
				[ShopId] IN (@OldId);
			
			DELETE
			FROM
				[dbo].[NeedToSupply]
			WHERE
				[ShopId] IN (@OldId);
			
			DELETE
			FROM
				[dbo].[WorkingShift]
			WHERE
				[ShopId] IN (@OldId);
			
		END
	
	--#endregion Shop Triggers
	
	--#region User Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_User') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_User;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_User
		ON [dbo].[User] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[Order]
			WHERE
				[UserId] IN (@OldId);
			
		END
	
	--#endregion User Triggers
	
	--#region Personal Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_Personal') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_Personal;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_Personal
		ON [dbo].[Personal] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[PersonalInWorkingShift]
			WHERE
				[PersonalId] IN (@OldId);
			
		END
	
	--#endregion Personal Triggers

	--#region Provider Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_Provider') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_Provider;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_Provider
		ON [dbo].[Provider] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[Supply]
			WHERE
				[ProviderId] IN (@OldId);
			
		END
	
	--#endregion Provider Triggers

	--#region ProductType Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_ProductType') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_ProductType;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_ProductType
		ON [dbo].[ProductType] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[Product]
			WHERE
				[ProductTypeId] IN (@OldId);
			
		END
	
	--#endregion ProductType Triggers

	--#region Product Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_Product') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_Product;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_Product
		ON [dbo].[Product] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[ProductInSupply]
			WHERE
				[ProductId] IN (@OldId);

			DELETE
			FROM
				[dbo].[ProductInShop]
			WHERE
				[ProductId] IN (@OldId);

			DELETE
			FROM
				[dbo].[NeedToSupply]
			WHERE
				[ProductId] IN (@OldId);

			DELETE
			FROM
				[dbo].[ProductInOrder]
			WHERE
				[ProductId] IN (@OldId);
			
		END
	
	--#endregion Product Triggers

	--#region WorkingShift Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_WorkingShift') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_WorkingShift;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_WorkingShift
		ON [dbo].[WorkingShift] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[PersonalInWorkingShift]
			WHERE
				[WorkingShiftId] IN (@OldId);
			
		END
	
	--#endregion WorkingShift Triggers

	--#region PersonalInWorkingShift Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_PersonalInWorkingShift') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_PersonalInWorkingShift;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_PersonalInWorkingShift
		ON [dbo].[PersonalInWorkingShift] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[Order]
			WHERE
				[PersonalInWorkingShiftId] IN (@OldId);
			
		END
	
	--#endregion PersonalInWorkingShift Triggers

	--#region Order Triggers
		
		IF OBJECT_ID(N'Trigger_Cascade_Delete_Order') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Cascade_Delete_Order;
		END
		GO

		CREATE TRIGGER Trigger_Cascade_Delete_Order
		ON [dbo].[Order] INSTEAD OF DELETE
		AS
		BEGIN
			
			DECLARE @OldId INT;
			
			SELECT @OldId = (SELECT [Id] FROM deleted);
			
			DELETE
			FROM
				[dbo].[ProductInOrder]
			WHERE
				[OrderId] IN (@OldId);

			DELETE
			FROM
				[dbo].[Check]
			WHERE
				[OrderId] IN (@OldId);
			
		END
	
	--#endregion Order Triggers

	--#region ProductInOrder Triggers
		
		IF OBJECT_ID(N'Trigger_Change_Product_Qty_ProductInOrder') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Change_Product_Qty_ProductInOrder;
		END
		GO

		CREATE TRIGGER Trigger_Change_Product_Qty_ProductInOrder
		ON [dbo].[ProductInOrder] AFTER INSERT
		AS
		BEGIN
			
			DECLARE @ShopId INT,
					@OrderId INT,
					@ProductId INT,
					@OldQty DECIMAL(18, 3),
					@OrderQty DECIMAL(18, 3);
			
			SELECT
				@OrderId = [OrderId],
				@ProductId = [ProductId],
				@OrderQty = [Quantity]
			FROM inserted;

			SELECT
				@ShopId = (SELECT
							ws.[ShopId] 
						   FROM
							[dbo].[WorkingShift] AS ws
							INNER JOIN [dbo].[PersonalInWorkingShift] AS piwsh
								ON piwsh.[WorkingShiftId] = ws.[Id]
							INNER JOIN [dbo].[Order] AS o
								ON o.[PersonalInWorkingShiftId] = piwsh.[Id]
						   WHERE
							o.[Id] = @OrderId);
			
			SELECT
				@OldQty = (SELECT
							[Quantity]
						  FROM
							[dbo].[ProductInShop]
						  WHERE
							[ShopId] = @ShopId AND [ProductId] = @ProductId);

			IF @OldQty - @OrderQty <= 0
			BEGIN

				INSERT INTO [dbo].[NeedToSupply] 
					([ProductId], [ShopId])
				VALUES
					(@ProductId, @ShopId);

				DELETE
				FROM
					[dbo].[ProductInShop]
				WHERE
					[ShopId] = @ShopId AND [ProductId] = @ProductId;

			END
			ELSE
			BEGIN
				
				UPDATE [dbo].[ProductInShop]
				SET
					[Quantity] = @OldQty - @OrderQty
				WHERE
					[ShopId] = @ShopId AND [ProductId] = @ProductId;

			END
			
		END
	
	--#endregion ProductInOrder Triggers

	--#region ProductInSupply Triggers
		
		IF OBJECT_ID(N'Trigger_Change_Product_Qty_ProductInSupply') IS NOT NULL
		BEGIN
			DROP TRIGGER Trigger_Change_Product_Qty_ProductInSupply;
		END
		GO

		CREATE TRIGGER Trigger_Change_Product_Qty_ProductInSupply
		ON [dbo].[ProductInSupply] AFTER INSERT
		AS
		BEGIN
			
			DECLARE @ShopId INT,
					@SupplyId INT,
					@ProductId INT,
					@SupplyPrice DECIMAL(18, 3),
					@SupplyQty DECIMAL(18, 3);
			
			SELECT
				@SupplyId = [SupplyId],
				@ProductId = [ProductId],
				@SupplyQty = [Quantity],
				@SupplyPrice = [NewPrice]
			FROM inserted;

			SELECT
				@ShopId = (SELECT
							[ShopId]
						   FROM
							[dbo].[Supply]
						   WHERE
							[Id] = @SupplyId);
			
			IF EXISTS(SELECT
						1
					  FROM
						[dbo].[ProductInShop]
					  WHERE
						[ShopId] = @ShopId AND [ProductId] = @ProductId)
			BEGIN

				DECLARE @OldQty DECIMAL(18, 3);

				SELECT
					@OldQty = [Quantity]
				FROM 
					[dbo].[ProductInShop]
				WHERE
					[ShopId] = @ShopId AND [ProductId] = @ProductId;

				UPDATE [dbo].[ProductInShop]
				SET
					[Quantity] = @OldQty + @SupplyPrice
				WHERE
					[ShopId] = @ShopId AND [ProductId] = @ProductId;

			END
			ELSE
			BEGIN
				
				INSERT INTO [dbo].[ProductInShop]
					([ProductId], [ShopId], [Price], [Quantity])
				VALUES
					(@ProductId, @ShopId, @SupplyPrice, @SupplyQty);

			END

			IF EXISTS(SELECT
						1
					  FROM
						[dbo].[NeedToSupply]
					  WHERE
						[ShopId] = @ShopId AND [ProductId] = @ProductId)
			BEGIN

				DELETE
				FROM
					[dbo].[NeedToSupply]
				WHERE
					[ShopId] = @ShopId AND [ProductId] = @ProductId;
			END
			
		END
	
	--#endregion ProductInSupply Triggers
	
--#endregion Triggers