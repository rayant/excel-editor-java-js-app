package com.xml_tables_task.model;

import javax.persistence.*;

/**
 * Created by RAYANT on 26.01.2016.
 */

@Entity
@Table(schema = "public",name="xls_tables")
public class XlsTable {

    @Id
    @Column(name = "id")
    @SequenceGenerator(name="auto_id_xls_tables",
            sequenceName="auto_id_xls_tables",
            allocationSize=1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator="auto_id_xls_tables")
    private int id;

    @Column(name = "name")
    private String name;

    public XlsTable() {
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "content")
    private String content;


    @Override
    public String toString() {
        return "XlsTable{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
