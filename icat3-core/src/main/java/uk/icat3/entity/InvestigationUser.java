package uk.icat3.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.UniqueConstraint;
import javax.xml.bind.Marshaller;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.log4j.Logger;

@Comment("Many to many relationship between investigation and user")
@SuppressWarnings("serial")
@Entity
@XmlRootElement
@TableGenerator(name = "investigationUserGenerator", pkColumnValue = "InvestigationUser")
@Table(uniqueConstraints = { @UniqueConstraint(columnNames = { "USER_ID", "INVESTIGATION_ID" }) })
public class InvestigationUser extends EntityBaseBean implements Serializable {

	private final static Logger logger = Logger.getLogger(InvestigationUser.class);

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "investigationUserGenerator")
	private Long id;

	private String role;

	@JoinColumn(name = "USER_ID", nullable = false)
	@ManyToOne
	private User user;

	@JoinColumn(name = "INVESTIGATION_ID", nullable = false)
	@ManyToOne
	private Investigation investigation;

	/* Needed for JPA */
	public InvestigationUser() {
	}

	@Override
	public String toString() {
		return "Investigator[id=" + id + "]";
	}

	@Override
	public Object getPK() {
		return id;
	}

	public void beforeMarshal(Marshaller source) {
		logger.trace("Marshalling Investigator for " + includes);
		if (!this.includes.contains(User.class)) {
			this.user = null;
		}
		if (!this.includes.contains(Investigation.class)) {
			this.investigation = null;
		}
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Investigation getInvestigation() {
		return investigation;
	}

	public void setInvestigation(Investigation investigation) {
		this.investigation = investigation;
	}

}