package com.awesomeproject.bean;

import java.util.List;

public class SinglePerson {

    private int age;
    private Computer computer;
    private List<_phone> phone;
    private String name;
    private double rich;
    private boolean sex;

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public Computer getComputer() {
        return computer;
    }

    public void setComputer(Computer computer) {
        this.computer = computer;
    }

    public List<_phone> getPhone() {
        return phone;
    }

    public void setPhone(List<_phone> phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getRich() {
        return rich;
    }

    public void setRich(double rich) {
        this.rich = rich;
    }

    public boolean isSex() {
        return sex;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public static class Computer {
        private String type;
        private double size;

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public double getSize() {
            return size;
        }

        public void setSize(double size) {
            this.size = size;
        }
    }

    public static class _phone {
        private String type;
        private double size;

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public double getSize() {
            return size;
        }

        public void setSize(double size) {
            this.size = size;
        }
    }
}
