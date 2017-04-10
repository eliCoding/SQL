/****** Object:  Database MyLibrary for assignment 2 in DataBase II

/****** Object:  Database [MyLibrary]    
Script Date: 2017-02-17
by team: Mike Yu, Elmira and Laurian ******/

-- add constraint for each table */


USE MyLibrary;
GO

-- apply constraint for table [items].[title] 

ALTER TABLE [items].[item] 
 ADD 
CONSTRAINT [FK_item_title] FOREIGN KEY([titleID])
REFERENCES [items].[title] ([titleID]);
go

ALTER TABLE [items].[copy] 
 ADD 
CONSTRAINT [FK_copy_title] FOREIGN KEY([titleID])
REFERENCES [items].[title] ([titleID]);
go

ALTER TABLE [lease].[LoanHist] 
 ADD 
CONSTRAINT [FK_LoanHist_title] FOREIGN KEY([titleID])
REFERENCES [items].[title] ([titleID]);
go

ALTER TABLE [lease].[Loan] 
 ADD 
CONSTRAINT [FK_Loan_title] FOREIGN KEY([titleID])
REFERENCES [items].[title] ([titleID]);
go

-- apply constraint for table [items].[item] 

ALTER TABLE [items].[copy] 
 ADD 
CONSTRAINT [FK_item_copy] FOREIGN KEY(ISBN)
REFERENCES [items].[item] (ISBN);

ALTER TABLE [lease].[Reservation] 
 ADD 
CONSTRAINT [FK_item_Reservation] FOREIGN KEY(ISBN)
REFERENCES [items].[item] (ISBN);

ALTER TABLE [lease].[loan] 
 ADD 
CONSTRAINT [FK_item_loan] FOREIGN KEY(ISBN)
REFERENCES [items].[item] (ISBN);

ALTER TABLE [lease].[loanhist] 
 ADD 
CONSTRAINT [FK_item_loanhist] FOREIGN KEY(ISBN)
REFERENCES [items].[item] (ISBN);
go

-- apply constraint for table [items].[copy]
 
ALTER TABLE [lease].[loanhist] 
 ADD 
CONSTRAINT [FK_copy_loanhist] FOREIGN KEY([ISBN],[CopyID])
REFERENCES [items].[copy] ([ISBN],[CopyID]);

ALTER TABLE [lease].[loan] 
 ADD 
CONSTRAINT [FK_copy_loan] FOREIGN KEY([ISBN],[CopyID])
REFERENCES [items].[copy] ([ISBN],[CopyID]);
go

-- apply constraint for table [members].[member]

ALTER TABLE [lease].[loan] 
 ADD  
 CONSTRAINT  [FK_loan_member] FOREIGN KEY(memberID)
REFERENCES [members].[member] (memberID);

ALTER TABLE [lease].[loanhist] 
 ADD  
 CONSTRAINT  [FK_loanhist_member] FOREIGN KEY(memberID)
REFERENCES [members].[member] (memberID);

ALTER TABLE [lease].[reservation] 
 ADD  
 CONSTRAINT  [FK_reservation_member] FOREIGN KEY(memberID)
REFERENCES [members].[member] (memberID);

ALTER TABLE [members].[adult] 
 ADD  
 CONSTRAINT  [FK_adult_member] FOREIGN KEY(memberID)
REFERENCES [members].[member] (memberID);

ALTER TABLE [members].[juvenile] 
 ADD  
 CONSTRAINT  [FK_juvenile_member] FOREIGN KEY(memberID)
REFERENCES [members].[member] (memberID);

go

-- apply constraint for between table [members].[adult] and [members].[juvenile]

ALTER TABLE [members].[juvenile] 
 ADD  
 CONSTRAINT  [FK_juvenile_adult] FOREIGN KEY([Adult_MemberID])
REFERENCES [members].[adult] (memberID);

-- apply constraint for table [lease].[loan]
ALTER TABLE [lease].[loan]
add  CONSTRAINT  chk_loan CHECK ([due_date]>[out_date] );

/** apply constraint for between table [lease].[loanhist]
ALTER TABLE [lease].[loanhist]
add  CONSTRAINT  chk_loanhist CHECK ([in_date]<[due_date]);

/**************************************
  THis constraint can not applly ince the database has confliction
	*********************************************************/
select * from [lease].[loanhist]
where ([in_date]<[due_date]);