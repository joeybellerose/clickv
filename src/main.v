module main 

import os

fn main() {

	exist := os.exists("clickhouse")

	println("${exist}")

	match exist {
		true { println("Clickhouse is already installed") }
		false { os.execute('curl https://clickhouse.com/ | sh')}
	}

	query:= "
	SELECT count()
	FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/house_parquet/house_0.parquet')
	"
	result := os.execute('./clickhouse local -q "${query}"') 


	println("${result.output}")
}
