package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class GardenApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(GardenApplication.class, args);
        System.out.println("保定植物园园林管理系统启动成功");
    }
}
