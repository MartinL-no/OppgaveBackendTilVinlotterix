USE [Vinlotterix]
GO
/****** Object:  Table [dbo].[Draw]    Script Date: 22/05/2023 13:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Draw](
	[Id] [uniqueidentifier] NOT NULL,
	[Time] [datetime] NOT NULL,
 CONSTRAINT [PK_Draw] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrawParticipant]    Script Date: 22/05/2023 13:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrawParticipant](
	[Id] [uniqueidentifier] NOT NULL,
	[DrawId] [uniqueidentifier] NOT NULL,
	[ParticipantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DrawParticipant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrawWinner]    Script Date: 22/05/2023 13:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrawWinner](
	[Id] [uniqueidentifier] NOT NULL,
	[DrawId] [uniqueidentifier] NOT NULL,
	[ParticipantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DrawWinner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participant]    Script Date: 22/05/2023 13:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participant](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Participant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Draw] ([Id], [Time]) VALUES (N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', CAST(N'2018-10-11T17:10:00.000' AS DateTime))
GO
INSERT [dbo].[Draw] ([Id], [Time]) VALUES (N'ff76700d-9da2-4c21-a7a6-e73fbcb75770', CAST(N'2018-10-17T17:10:00.000' AS DateTime))
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'72714c65-1b34-42fb-967a-222b853948d6', N'ff76700d-9da2-4c21-a7a6-e73fbcb75770', N'6fa652f1-fcef-4fb6-8734-b95b27728f4c')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'25ef8b7b-68eb-4308-8e9d-281ff8032eda', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'14d3fe03-9816-4b08-aeb0-5d87ac850669')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'c49c884d-0fd9-40f2-86ba-4b9cde9a5b93', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'6fa652f1-fcef-4fb6-8734-b95b27728f4c')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'4e7dc407-c7a0-4df0-a59c-7e9f1d721634', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'a6618043-5e2e-46b1-9959-75bf970fafcd')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'e8d6557e-5845-442c-9787-bc7a27c1bdf5', N'ff76700d-9da2-4c21-a7a6-e73fbcb75770', N'14d3fe03-9816-4b08-aeb0-5d87ac850669')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'd5bdc004-68bd-455b-b621-99367bb0417c')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'6ce96e0a-5a0c-416f-b2c3-be8da2a7ec87', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'bd8871da-5c8a-4330-a9c1-8e223a2e0e19')
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (N'ed9aade6-9d29-4bd5-a7ff-fd3317765576', N'ff76700d-9da2-4c21-a7a6-e73fbcb75770', N'a6618043-5e2e-46b1-9959-75bf970fafcd')
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (N'd68647f1-fbf6-4c97-9f59-1e3d7e7ad44f', N'ff76700d-9da2-4c21-a7a6-e73fbcb75770', N'a6618043-5e2e-46b1-9959-75bf970fafcd')
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (N'f45ed918-8c20-4813-a442-318cf6d84179', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'14d3fe03-9816-4b08-aeb0-5d87ac850669')
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (N'e11316d1-ac7b-4b49-8b50-3223eda47237', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'6fa652f1-fcef-4fb6-8734-b95b27728f4c')
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (N'0d832d2b-46b4-4885-8c97-6bff89ebd876', N'e08b1add-e9a2-499d-8e5e-bd6b92011dc5', N'a6618043-5e2e-46b1-9959-75bf970fafcd')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (N'd2bf7b0c-3c05-4fef-9d01-5b30a258412d', N'Espen')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (N'14d3fe03-9816-4b08-aeb0-5d87ac850669', N'Pål')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (N'a6618043-5e2e-46b1-9959-75bf970fafcd', N'Ole')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (N'bd8871da-5c8a-4330-a9c1-8e223a2e0e19', N'Gunnar')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (N'd5bdc004-68bd-455b-b621-99367bb0417c', N'Knut')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (N'6fa652f1-fcef-4fb6-8734-b95b27728f4c', N'Per')
GO
ALTER TABLE [dbo].[DrawParticipant]  WITH CHECK ADD  CONSTRAINT [FK_DrawParticipant_Draw] FOREIGN KEY([DrawId])
REFERENCES [dbo].[Draw] ([Id])
GO
ALTER TABLE [dbo].[DrawParticipant] CHECK CONSTRAINT [FK_DrawParticipant_Draw]
GO
ALTER TABLE [dbo].[DrawParticipant]  WITH CHECK ADD  CONSTRAINT [FK_DrawParticipant_Participant] FOREIGN KEY([ParticipantId])
REFERENCES [dbo].[Participant] ([Id])
GO
ALTER TABLE [dbo].[DrawParticipant] CHECK CONSTRAINT [FK_DrawParticipant_Participant]
GO
ALTER TABLE [dbo].[DrawWinner]  WITH CHECK ADD  CONSTRAINT [FK_DrawWinner_Draw] FOREIGN KEY([DrawId])
REFERENCES [dbo].[Draw] ([Id])
GO
ALTER TABLE [dbo].[DrawWinner] CHECK CONSTRAINT [FK_DrawWinner_Draw]
GO
ALTER TABLE [dbo].[DrawWinner]  WITH CHECK ADD  CONSTRAINT [FK_DrawWinner_Participant] FOREIGN KEY([ParticipantId])
REFERENCES [dbo].[Participant] ([Id])
GO
ALTER TABLE [dbo].[DrawWinner] CHECK CONSTRAINT [FK_DrawWinner_Participant]
GO