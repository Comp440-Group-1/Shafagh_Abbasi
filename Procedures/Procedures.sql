USE [440Project]
GO
/****** Object:  StoredProcedure [dbo].[DownloadReport]    Script Date: 5/2/2016 3:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DownloadReport]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY  
		SELECT P.[product_name],
			  D.[product_version],
			  MONTH(D.download_date) AS [Month],
			  COUNT(MONTH(D.download_date)) AS [Count]  
		FROM product P
		INNER JOIN download D ON D.product_id = P.product_id 
		GROUP BY P.[product_name], D.[product_version], MONTH(D.download_date);
	END TRY

  	BEGIN CATCH
		    DECLARE @ErrorNumber INT = ERROR_NUMBER();
			DECLARE @ErrorLine INT = ERROR_LINE();
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
			DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
			DECLARE @ErrorState INT = ERROR_STATE();
		
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[FeatureReport]    Script Date: 5/2/2016 3:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FeatureReport]
@DesiredRelease varchar(20)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @NewFeatures int;
		SELECT  @NewFeatures = COUNT(F.feature_name)FROM feature F
		INNER JOIN development_release_feature DRF ON F.feature_id = DRF.feature_id
		INNER JOIN development_release DR ON DR.iteration_id = DRF.iteration_id
		INNER JOIN customer_release CR ON CR.release_id = DR.release_id
		INNER JOIN release_version RV ON RV.release_id = CR.release_id
		WHERE RV.release_name = @DesiredRelease 
		AND F.feature_name NOT LIKE '%bug fix%'
 
				
		DECLARE @FixFeatures int;
		SELECT  @FixFeatures = COUNT(F.feature_name)FROM feature F
		INNER JOIN development_release_feature DRF ON F.feature_id = DRF.feature_id
		INNER JOIN development_release DR ON DR.iteration_id = DRF.iteration_id
		INNER JOIN customer_release CR ON CR.release_id = DR.release_id
		INNER JOIN release_version RV ON RV.release_id = CR.release_id
		WHERE RV.release_name = @DesiredRelease 
		AND F.feature_name LIKE '%bug fix%'

		IF (@NewFeatures != 0)
			PRINT '['+ CAST(@NewFeatures AS VARCHAR) +'] new features are in  ['+ @DesiredRelease +'] release'

		IF (@FixFeatures != 0)
			PRINT 'There are [' + CAST(@FixFeatures AS VARCHAR) + '] bug –fix release. There are no new features in ['+ @DesiredRelease +'] release' 

		IF (@DesiredRelease IS NULL)
			PRINT 'You should enter a valid release number'

	END TRY
	BEGIN CATCH
		    DECLARE @ErrorNumber INT = ERROR_NUMBER();
			DECLARE @ErrorLine INT = ERROR_LINE();
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
			DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
			DECLARE @ErrorState INT = ERROR_STATE();
		
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[InsertCompanyInfo]    Script Date: 5/2/2016 3:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCompanyInfo]
@CompanyName varchar(30),
@CompanyStreet varchar(50),
@CompanyStreet1 varchar(50),
@CompanyCity varchar (50),
@CompanyZip varchar(50),
@CompanyState varchar(10),
@CompanyCountry varchar(50)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
	--INSERT company name in company table
	IF(@CompanyName IS NOT NULL)
		BEGIN
			INSERT INTO company(company_name) VALUES (@CompanyName)
		END
	ELSE
		PRINT'Company name can not be empty'

	--INSERT county name in country table
	IF(@CompanyCountry IS NOT NULL)
		BEGIN
			DECLARE @Country_id int;
			IF ((SELECT country_id FROM country WHERE country_name=@CompanyCountry) Is NULL)
				BEGIN
					INSERT INTO country(country_name) 
					VALUES (@CompanyCountry)
 					SELECT @Country_id = country_id FROM country WHERE country_name=@CompanyCountry
				END
			ELSE
				BEGIN
					SELECT @Country_id = country_id FROM country WHERE country_name=@CompanyCountry
				END
		END

    --INSERT state name in state table
	IF(@CompanyState IS NOT NULL)
		BEGIN
			DECLARE @State_id int; 
				IF ((SELECT state_id FROM [state] WHERE state_name=@CompanyState) IS NULL)
					BEGIN
						INSERT INTO [state](state_name) 
						VALUES (@CompanyState)
						SELECT @State_id = state_id FROM [state] WHERE state_name=@CompanyState
					END
				ELSE
					BEGIN
						SELECT @State_id = state_id FROM [state] WHERE state_name=@CompanyState
					END
			END

    --INSERT city name in city table
	IF(@CompanyCity IS NOT NULL)
		BEGIN
			DECLARE @City_id int; 
				IF ((SELECT city_id FROM city WHERE city_name=@CompanyCity) IS NULL)
					BEGIN
						INSERT INTO [city](city_name,zipcode,country_id,state_id) 
						VALUES (@CompanyCity,@CompanyZip,@Country_id,@State_id)
						SELECT @City_id = city_id FROM [city] WHERE city_name=@CompanyCity
					END
		END

	--INSERT street in address table
	IF(@CompanyStreet IS NOT NULL)
	DECLARE @Company_id int; 
		BEGIN
			SELECT @Company_id = company_id FROM [company] WHERE company_name=@CompanyName
			INSERT INTO company_address(street,street1,company_id,city_id) 
			VALUES (@CompanyStreet,@CompanyStreet1,@Company_id,@City_id)
		END

	PRINT'Address submitted successfully'

	END TRY
	BEGIN CATCH
		    DECLARE @ErrorNumber INT = ERROR_NUMBER();
			DECLARE @ErrorLine INT = ERROR_LINE();
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
			DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
			DECLARE @ErrorState INT = ERROR_STATE();
		
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
   
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateVersion]    Script Date: 5/2/2016 3:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateVersion]
@OldVersion float,
@NewVersion float
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
	IF ((SELECT TOP 1 RV.[product_version] FROM release_version RV WHERE RV.[product_version] LIKE @OldVersion) IS NULL) 
		PRINT 'Entered Version Is not Correct. No Change made '
	ELSE 
		BEGIN
			UPDATE release_version 
			SET [product_version] = @NewVersion
			WHERE [product_version] like @OldVersion
			UPDATE download
			SET [product_version] = @NewVersion
			WHERE [product_version] like @OldVersion
			PRINT 'Update Successfully ';
		END
	END TRY
	BEGIN CATCH
		    DECLARE @ErrorNumber INT = ERROR_NUMBER();
			DECLARE @ErrorLine INT = ERROR_LINE();
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
			DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
			DECLARE @ErrorState INT = ERROR_STATE();
		
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
   
END

GO
