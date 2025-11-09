package org.org.ogkm.Lib.entity;

import org.org.ogkm.Lib.exception.DataInvalidException;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

public class Customer {
  private String id; //ROC ID, PKey,
  private String name; //required, 2~20字元
  private String email; //required,須符合email格式,unique index
  private String password;//required, 6~20字元
  private LocalDate birthday;//required,年滿12歲, iso 8601
  private char gender; //required,M:男,F:女,O:其他
  //private BloodType bloodType;
  private String address = "";
  private String address1 = "";
  private String phone = "";
  private boolean subscribed;

  private boolean admin=false;

  public Customer() {}

  public Customer(String id, String name,
                  String password, String email) {
    this(id, name, password);
    this.setEmail(email);
  }

  public Customer(String id, String name, String pwd) {
    this.setId(id);
    this.setName(name);
    this.setPassword(pwd);
  }

  //id
  public void setId(String id) throws DataInvalidException {
    if (checkId(id)) {
      this.id = id;
    } else {
      throw new DataInvalidException("身分證號格式不正確");
    }
  }

  public static final String IP_PATTERN = "([a-zA-Z]{1}[1289]{1}[\\d]{8})";

  public boolean checkId(String id) {
    char idchar1 = id.charAt(0);
    int Idnum1 = 0;
    if (id.matches(IP_PATTERN)) {
      id = id.toUpperCase();
      if (idchar1 >= 'A' && idchar1 <= 'H')
        Idnum1 = (idchar1 - 65) + 10;
      else if (idchar1 >= 'J' && idchar1 <= 'N')
        Idnum1 = (idchar1 - 65) + 9;
      else if (idchar1 >= 'P' && idchar1 <= 'V')
        Idnum1 = (idchar1 - 65) + 8;
      else if (idchar1 >= 'X' && idchar1 <= 'Y')
        Idnum1 = (idchar1 - 65) + 7;
      else
        switch (idchar1) {
          case 87: // 'W'
            Idnum1 = 32;
            break;
          case 90: // 'Z'
            Idnum1 = 33;
            break;
          case 73: // 'I'
            Idnum1 = 34;
            break;
          case 79: // 'O'
            Idnum1 = 35;
            break;
          default:
            return false;
        }

      int sum = Idnum1 / 10 + (Idnum1 % 10) * 9;
      int j = 8;
      for (int i = 1; i <= 8; i++) {
        sum += (id.charAt(i) - '0') * j;
        j--;
      }
      sum += (id.charAt(9) - '0');
      return sum % 10 == 0;
    } else {
      return false;
    }
  }

  public String getId() {
    return this.id;
  }
  //id結束

  //name
  public static final int MIN_NAME_LENGTH = 2;
  public static final int MAX_NAME_LENGTH = 20;

  public void setName(String name) {
    if (name != null &&
        (name = name.strip()).length() >= MIN_NAME_LENGTH && name.length() <= MAX_NAME_LENGTH) {
      this.name = name;
    } else {
      String msg = String.format("姓名必須輸入且長度在%d~%d之間",
          MIN_NAME_LENGTH, MAX_NAME_LENGTH);
      throw new DataInvalidException(msg);
    }
  }

  public String getName() {
    return name;
  }
  //name結束

  //email
  public static final String emailregex = "^([\\w]+)@([\\w]+)\\.([\\w]+)$";
  public static final String emailregex1 = "^([\\w]+)@([[\\w]]+)\\.([\\w]+)\\.([a-zA-Z]+)$";

  public void setEmail(String email) {
    boolean emailTF = email.matches(emailregex);
    if (emailTF) {
      this.email = email;
      // System.out.println("email正確");
    } else {
      emailTF = email.matches(emailregex1);
      if (emailTF) {
        this.email = email;
        // System.out.println("email正確");
      } else {
        String msg = String.format("email必須輸入符合格式");
        throw new DataInvalidException(msg);
      }
    }
  }

  public String getEmail() {
    return email;
  }
  //email結束

  //password
  public static final int MIN_PWD_LENGTH = 6;
  public static final int MAX_PWD_LENGTH = 15;

  public void setPassword(String password) {
    String passwordregex = "^([a-zA-Z0-9]+)$";
    boolean passwordTF = password.matches(passwordregex);
    if (passwordTF) {
      if (password.length() >= MIN_PWD_LENGTH && password.length() <= MAX_PWD_LENGTH) {
        this.password = password;
        // System.out.println("密碼合格");
      } else {
        String msg = String.format("密碼必須輸入,長度在%d~%d之間",
            MIN_PWD_LENGTH, MAX_PWD_LENGTH);
        throw new DataInvalidException(msg);
      }
    } else {
      String msg = String.format("密碼不能有符號,空白，只能有英數字");
      throw new DataInvalidException(msg);
    }
  }

  public String getPassword() {
    return password;
  }
  /*password結束*/

  /*getAge*/

  /**
   * 計算客戶的年齡
   */
  public int getAge() {
    return this.getAge(this.birthday);
  }

  /**
   * 計算指定生日birthday的年齡
   * @param birthday:指定生日birthday
   */
  public int getAge(LocalDate birthday) {
    int thisYear = LocalDate.now().getYear();
    if (birthday != null) {
      int age = Period.between(birthday, LocalDate.now()).getYears();
      return age;
    } else {
      return -1;
      //TODO:第13章 改(拋出)throw exception物件;
    }
  }
  /*getAge結束*/

  /*birthday*/
  public static final int AGE = 12;

  public void setBirthday(LocalDate birthday) {
    if (birthday != null && getAge(birthday) >= AGE) {
      this.birthday = birthday;
    } else {
      String msg = String.format("生日必須輸入且年滿%d歲", AGE);
      throw new DataInvalidException(msg);
    }
  }

  public void setBirthday(String date) {
    try {
      this.setBirthday(LocalDate.parse(date));
    } catch (DateTimeParseException e) {
      String msg = String.format("%s日期不符合iso-8601: yyyy-MM-dd", date);
      throw new DataInvalidException(msg);
    }
  }

  public void setBirthday(int year, int month, int day) {
    try {
      this.setBirthday(LocalDate.of(year, month, day));
    } catch (java.time.DateTimeException ex) {
      throw new DataInvalidException("日期資料不正確:" + ex.getMessage());
    }
  }

  public LocalDate getBirthday() {
    return birthday;
  }
  /*birthday結束*/

  /*gender開始*/
  public static final char MALE = 'M';
  public static final char OTHER = 'O';
  public static final char FEMALE = 'F';

  public void setGender(char gender) {
    //String genderString = (new StringBuilder(String.valueOf(gender))).toString();//轉字串
    //String genderString = gender+"";//轉字串原本
    String genderString = String.valueOf(gender);//轉字串
    genderString = genderString.toUpperCase();//轉大寫
    gender = genderString.charAt(0);//轉字元
    if (gender == FEMALE || gender == MALE || gender == OTHER) {
      this.gender = gender;
    } else {
      String msg = String.format("性別不正確，應為男:%s,女:%s,其他:%s",
          MALE, FEMALE, OTHER);
      throw new DataInvalidException(msg);
    }
  }

  public char getGender() {
    return gender;
  }
  // gender結束

  // address

  public void setAddress(String address) {
    if (address != null && address.length() > 0) {
      address = address.trim();
    } else if (address == null) {
      address = "";
    }
    this.address = address;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress1(String address1) {
    if (address1 != null && address1.length() > 0) {
      address1 = address1.trim();
    } else if (address1 == null) {
      address1 = "";
    }
    this.address1 = address1;
  }

  public String getAddress1() {
    return address1;
  }

  // address結束

  // phone結束
  public void setPhone(String phone) {
    if (phone != null) {
      if (phone.length() > 0) phone = phone.trim();
      this.phone = phone;
    } else {
      this.phone = "";
    }
  }

  public String getPhone() {
    if (phone != null && phone.length() > 0) {
      phone = phone.trim();
    }
    return phone;
  }
  // phone結束

  // subscribed
  public boolean isSubscribed() {
    return subscribed;
  }

  public void setSubscribed(boolean subscribed) {
    this.subscribed = subscribed;
  }
  // subscribed結束

  public boolean isAdmin() {
    return admin;
  }

  public void setAdmin(boolean admin) {
    this.admin = admin;
  }

  //@Override
  public String toString() {
    return this.getClass().getSimpleName() + ":"
        + "\nid:" + id
        + "\n姓名:" + name
        + "\n密碼:" + password
        + "\n電郵:" + email
        + "\n生日:" + birthday
        + "\n歲數:" + getAge()
        + "\n性別:" + gender
        + "\n地址:" + address
        + "\n地址1:" + address1
        + "\n電話:" + phone
        + "\n訂閱電子報:" + subscribed
        + "\n權限:" + admin;
  }

  @Override
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((id == null) ? 0 : id.hashCode());
    return result;
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj) {
      return true;
    }
    if (!(obj instanceof Customer)) {
      return false;
    }
    Customer other = (Customer) obj;
    if (id == null) {
      //if (other.id != null) {
      return false;
      //}
    } else if (!id.equals(other.id)) {
      return false;
    }
    return true;
  }

}
