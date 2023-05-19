USE [Vinlotterix]
GO
/****** Object:  Table [dbo].[Draw]    Script Date: 16/05/2023 15:20:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Draw](
	[Id] [int] NOT NULL,
	[Time] [datetime2](7) NULL,
	[ghg] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrawParticipant]    Script Date: 16/05/2023 15:20:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrawParticipant](
	[Id] [int] NOT NULL,
	[DrawId] [int] NULL,
	[ParticipantId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrawWinner]    Script Date: 16/05/2023 15:20:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrawWinner](
	[Id] [int] NOT NULL,
	[DrawId] [int] NULL,
	[ParticipantId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participant]    Script Date: 16/05/2023 15:20:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participant](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Draw] ([Id], [Time], [ghg]) VALUES (1, CAST(N'2018-10-17T17:10:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[Draw] ([Id], [Time], [ghg]) VALUES (2, CAST(N'2018-10-11T17:10:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (1, 1, 1)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (2, 1, 2)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (3, 1, 4)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (4, 2, 1)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (5, 2, 2)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (6, 2, 4)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (7, 2, 5)
GO
INSERT [dbo].[DrawParticipant] ([Id], [DrawId], [ParticipantId]) VALUES (8, 2, 6)
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (1, 1, 4)
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (2, 2, 1)
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (3, 2, 2)
GO
INSERT [dbo].[DrawWinner] ([Id], [DrawId], [ParticipantId]) VALUES (4, 2, 5)
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (1, N'Per')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (2, N'Pål')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (3, N'Espen')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (4, N'Ole')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (5, N'Knut')
GO
INSERT [dbo].[Participant] ([Id], [Name]) VALUES (6, N'Gunmar')
GO
ALTER TABLE [dbo].[DrawParticipant]  WITH CHECK ADD FOREIGN KEY([DrawId])
REFERENCES [dbo].[Draw] ([Id])
GO
ALTER TABLE [dbo].[DrawParticipant]  WITH CHECK ADD FOREIGN KEY([ParticipantId])
REFERENCES [dbo].[Participant] ([Id])
GO
ALTER TABLE [dbo].[DrawWinner]  WITH CHECK ADD FOREIGN KEY([DrawId])
REFERENCES [dbo].[Draw] ([Id])
GO
ALTER TABLE [dbo].[DrawWinner]  WITH CHECK ADD FOREIGN KEY([ParticipantId])
REFERENCES [dbo].[Participant] ([Id])
GO