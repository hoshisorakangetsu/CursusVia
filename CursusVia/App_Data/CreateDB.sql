CREATE TABLE [dbo].[FileResources]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [file_path] NVARCHAR(MAX) NOT NULL, 
    [file_name] NVARCHAR(MAX) NOT NULL
)

CREATE TABLE [dbo].[Admins]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [username] NVARCHAR(50) NOT NULL, 
    [password] NVARCHAR(255) NOT NULL, 
    [email] NVARCHAR(50) NOT NULL
)

CREATE TABLE [dbo].[Students]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [email] NVARCHAR(50)  NULL, 
    [password] NVARCHAR(50)  NULL, 
    [name] NVARCHAR(50) NOT NULL,
    [login_otp] NVARCHAR(50)  NULL,
    [login_otp_created] NVARCHAR(50) NULL,
    [is_active] INT  NULL
)

CREATE TABLE [dbo].[Tutors]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [name] NVARCHAR(50) NOT NULL, 
    [qualifications] NVARCHAR(50)  NULL, 
    [password] NVARCHAR(50)  NULL, 
    [email] NVARCHAR(50)  NULL, 
    [balance] FLOAT  NULL,
    [login_otp] NVARCHAR(50)  NULL,
    [login_otp_created] NVARCHAR(50) NULL,
    [is_active] INT  NULL
)

CREATE TABLE [dbo].[Answers]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [answer_content] NVARCHAR(MAX) NOT NULL
)

CREATE TABLE [dbo].[Courses]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [title] NVARCHAR(50) NOT NULL, 
    [description] NVARCHAR(MAX) NOT NULL, 
    [category] NVARCHAR(20) NOT NULL,
    [price] FLOAT NOT NULL, 
    [cover_pic_res_id] INT NOT NULL, 
    [tutor_id] INT NOT NULL, 
    CONSTRAINT [FK_Course_FileResources] FOREIGN KEY ([cover_pic_res_id]) REFERENCES [FileResources]([id]), 
    CONSTRAINT [FK_Course_Tutors] FOREIGN KEY ([tutor_id]) REFERENCES [Tutors]([id]) 
)

CREATE TABLE [dbo].[Chapters]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [title] NVARCHAR(50) NOT NULL, 
    [course_id] INT NOT NULL, 
    CONSTRAINT [FK_Chapters_Courses] FOREIGN KEY ([course_id]) REFERENCES [Courses]([id])
)

CREATE TABLE [dbo].[ChapterQuiz]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [quiz_title] NVARCHAR(50) NOT NULL,
    [chapter_id] INT NOT NULL, 
    CONSTRAINT [FK_ChapterQuiz_Chapters] FOREIGN KEY ([chapter_id]) REFERENCES [Chapters]([id])
)

CREATE TABLE [dbo].[Companies] (
    [id]       INT           IDENTITY (1, 1) NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [address]  NVARCHAR (50) NOT NULL,
    [postcode] NVARCHAR (15) NOT NULL,
    [state]    NVARCHAR (50) NOT NULL,
    [area]     NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[QuizQuestions]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [question] NVARCHAR(MAX) NOT NULL, 
    [order] INT NOT NULL, 
    [quiz_id] INT NOT NULL, 
    CONSTRAINT [FK_QuizQuestions_ChapterQuiz] FOREIGN KEY ([quiz_id]) REFERENCES [ChapterQuiz]([id])
)

CREATE TABLE [dbo].[QuizAnswers]
(
	[answer_id] INT NOT NULL , 
    [question_id] INT NOT NULL, 
    [is_correct] BIT NOT NULL, 
    CONSTRAINT [FK_QuizAnswers_Answers] FOREIGN KEY ([answer_id]) REFERENCES [Answers]([id]), 
    CONSTRAINT [FK_QuizAnswers_QuizQuestions] FOREIGN KEY ([question_id]) REFERENCES [QuizQuestions]([id]), 
    PRIMARY KEY ([question_id], [answer_id])
)

CREATE TABLE [dbo].[ChapterContents]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [title] NVARCHAR(50) NOT NULL, 
    [content] NVARCHAR(MAX) NOT NULL, 
    [order] INT NOT NULL, 
    [vid_res_id] INT NOT NULL,
    [chapter_id] INT NOT NULL, 
    CONSTRAINT [FK_ChapterContents_FileResources] FOREIGN KEY ([vid_res_id]) REFERENCES [FileResources]([id]),
    CONSTRAINT [FK_ChapterContents_Chapters] FOREIGN KEY ([chapter_id]) REFERENCES [Chapters]([id])
)

CREATE TABLE [dbo].[ContentResources]
( 
    [content_id] INT NOT NULL, 
    [resource_id] INT NOT NULL, 
    CONSTRAINT [FK_ContentResources_Contents] FOREIGN KEY ([content_id]) REFERENCES [ChapterContents]([id]), 
    CONSTRAINT [FK_ContentResources_FileResources] FOREIGN KEY ([resource_id]) REFERENCES [FileResources]([id]), 
    CONSTRAINT [PK_ContentResources] PRIMARY KEY ([resource_id], [content_id])
)

CREATE TABLE [dbo].[TutorRatings]
(
	[student_id] INT NOT NULL , 
    [tutor_id] INT NOT NULL, 
    [rating] INT NOT NULL, 
    CONSTRAINT [FK_TutorRatings_Students] FOREIGN KEY ([student_id]) REFERENCES [Students]([id]), 
    CONSTRAINT [FK_TutorRatings_Tutors] FOREIGN KEY ([tutor_id]) REFERENCES [Tutors]([id]), 
    PRIMARY KEY ([tutor_id], [student_id])
)

CREATE TABLE [dbo].[Payments]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [payment_amount] FLOAT NOT NULL, 
    [payment_date] DATETIME NOT NULL, 
    [transaction_method] NVARCHAR(50) NOT NULL, 
    [student_id] INT NOT NULL, 
    CONSTRAINT [FK_Payments_Students] FOREIGN KEY ([student_id]) REFERENCES [Students]([id])
)

CREATE TABLE [dbo].[PurchasedCourses] (
    [id]         INT IDENTITY (1, 1) NOT NULL,
    [rating]     INT NULL,
    [course_id]  INT NOT NULL,
    [student_id] INT NOT NULL,
    [payment_id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_PurchasedCourses_Courses] FOREIGN KEY ([course_id]) REFERENCES [dbo].[Courses] ([id]),
    CONSTRAINT [FK_PurchasedCourses_Students] FOREIGN KEY ([student_id]) REFERENCES [dbo].[Students] ([id]),
    CONSTRAINT [FK_PurchasedCourses_Payments] FOREIGN KEY ([payment_id]) REFERENCES [dbo].[Payments] ([id])
)

CREATE TABLE [dbo].[Vacancies] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [job_title]       NVARCHAR (50)  NOT NULL,
    [min_salary]      FLOAT (53)     NOT NULL,
    [max_salary]      FLOAT (53)     NOT NULL,
    [type]            NVARCHAR (20)  NOT NULL,
    [role]            NVARCHAR (50)  NOT NULL,
    [job_requirement] NVARCHAR (MAX) NOT NULL,
    [job_description] NVARCHAR (MAX) NOT NULL,
    [company_id]      INT            NOT NULL,
    [email]           NVARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Vacancies_Company] FOREIGN KEY ([company_id]) REFERENCES [dbo].[Companies] ([id])
);

CREATE TABLE [dbo].[JobApplications]
(
	[vacancy_id] INT NOT NULL , 
    [student_id] INT NOT NULL, 
    [resume_resource_id] INT NOT NULL, 
    [expecred_salary] FLOAT NOT NULL, 
    CONSTRAINT [FK_JobApplications_Vacancies] FOREIGN KEY ([vacancy_id]) REFERENCES [Vacancies]([id]), 
    CONSTRAINT [FK_JobApplications_Students] FOREIGN KEY ([student_id]) REFERENCES [Students]([id]), 
    CONSTRAINT [FK_JobApplications_FileResources] FOREIGN KEY ([resume_resource_id]) REFERENCES [FileResources]([id]), 
    PRIMARY KEY ([student_id], [vacancy_id])
)


CREATE TABLE [dbo].[CartItems]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [course_id] INT NOT NULL, 
    [student_id] INT NOT NULL, 
    CONSTRAINT [FK_CartItems_Courses] FOREIGN KEY ([course_id]) REFERENCES [Courses]([id]), 
    CONSTRAINT [FK_CartItems_Students] FOREIGN KEY ([student_id]) REFERENCES [Students]([id]),
)

CREATE TABLE [dbo].[WithdrawalRequests]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [withdraw_amount] FLOAT NOT NULL, 
    [request_date] DATE NOT NULL, 
    [status] NVARCHAR(50) NOT NULL, 
    [account_number] NVARCHAR(50) NOT NULL, 
	[bank_name] NVARCHAR(50) NOT NULL,
	[account_holder_name] NVARCHAR(50) NOT NULL,
    [tutor_id] INT NOT NULL, 
    CONSTRAINT [FK_WithdrawalRequests_Tutors] FOREIGN KEY ([tutor_id]) REFERENCES [Tutors]([id])
)

CREATE TABLE [dbo].[Payout]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [total_payout] FLOAT NOT NULL, 
    [payout_method] NVARCHAR(50) NOT NULL, 
    [payout_date] DATE NOT NULL, 
    [status] NVARCHAR(50) NOT NULL, 
    [withdraw_request] INT NOT NULL, 
    [tutor_id] INT NOT NULL, 
    [admin_id] INT NOT NULL, 
    CONSTRAINT [FK_Payout_Tutors] FOREIGN KEY ([tutor_id]) REFERENCES [Tutors]([id]), 
    CONSTRAINT [FK_Payout_Admins] FOREIGN KEY ([admin_id]) REFERENCES [Admins]([id]), 
    CONSTRAINT [FK_Payout_WithdrawalRequests] FOREIGN KEY ([withdraw_request]) REFERENCES [WithdrawalRequests]([id])
)

CREATE TABLE [dbo].[SupportRequests]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [title] NVARCHAR(50) NOT NULL, 
    [date_send] DATETIME NOT NULL, 
    [description] NVARCHAR(MAX) NOT NULL, 
    [status] NVARCHAR(50) NOT NULL, 
    [tutor_id] INT NULL, 
    [student_id] INT NULL, 
    CONSTRAINT [FK_SupportRequests_Tutors] FOREIGN KEY ([tutor_id]) REFERENCES [Tutors]([id]), 
    CONSTRAINT [FK_SupportRequests_Students] FOREIGN KEY ([student_id]) REFERENCES [Students]([id])
)

CREATE TABLE [dbo].[Replies] (
    [reply]          NVARCHAR (MAX) NOT NULL,
    [datetime]       DATETIME       NOT NULL,
    [support_req_id] INT            NOT NULL,
    [admin_id]       INT            NULL,
    [student_id]     INT            NULL,
    [tutor_id]       INT            NULL,
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Replies_SupportRequests] FOREIGN KEY ([support_req_id]) REFERENCES [dbo].[SupportRequests] ([id]),
    CONSTRAINT [student_id] FOREIGN KEY ([student_id]) REFERENCES [dbo].[Students] ([id]),
    CONSTRAINT [tutor_id] FOREIGN KEY ([tutor_id]) REFERENCES [dbo].[Tutors] ([id]),
    CONSTRAINT [FK_Replies_Admins] FOREIGN KEY ([admin_id]) REFERENCES [dbo].[Admins] ([id])
);
