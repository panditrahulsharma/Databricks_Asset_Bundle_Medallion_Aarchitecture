from databricks.connect import DatabricksSession
spark = DatabricksSession.builder.remote(serverless=True).getOrCreate()


def metadata(env):
    spark.sql("show catalogs").show()
    
    spark.sql(f"create catalog if not exists citibike_{env}")
    spark.sql(f"use catalog citibike_{env}")
    
    spark.sql("""create schema if not exists 00_landing""")
    spark.sql("""create schema if not exists 01_bronze""")
    spark.sql("""create schema if not exists 02_silver""")
    spark.sql("""create schema if not exists 03_gold""")
    # Create volume
    spark.sql("""
        CREATE VOLUME IF NOT EXISTS `00_landing`.source_citibike_data
    """)

    print(f"Catalog and schemas created for environment: {env}")


metadata("dev")
metadata("test")
metadata("prod")

spark.stop()