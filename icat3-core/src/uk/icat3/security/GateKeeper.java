package uk.icat3.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import org.apache.log4j.Logger;
import uk.icat3.exceptions.InsufficientPrivilegesException;
import uk.icat3.util.AccessType;
import javax.persistence.EntityManager;
import uk.icat3.entity.Datafile;
import uk.icat3.entity.DatafileParameter;
import uk.icat3.entity.Dataset;
import uk.icat3.entity.DatasetParameter;
import uk.icat3.entity.Investigation;
import uk.icat3.entity.InvestigationLevelPermission;
import uk.icat3.entity.Sample;
import uk.icat3.entity.SampleParameter;
import uk.icat3.entity.Study;
import uk.icat3.entity.StudyInvestigation;

/*
 * GateKeeper.java
 *
 * Created on 13 February 2007, 08:41
 *
 * GateKeeper is the principal authorisation service for the ICAT3 API.
 * This class is typically used internally by the coarser-grained SOA
 * services offered by the API.  Authorisation can be performed on a request
 * to perform an operation on any of the core elements (or entities) of the
 * ICAT3 database model/schema.
 *
 * <p>Each operation will require a user e.g. 'distinguished name', elementType
 * e.g. 'Datafile' and an access type e.g. 'READ'. An EntityManager will also
 * be passed in to each of the authorisation methods.  This allows each method
 * to be self-contained allowing its publication via standalone JPA or via a
 * J2EE application server</p>
 *
 * <p>Each step within the authorisation process is logged via LOG4J at the
 * appropriate log levels.  Typed exceptions are thrown where necessary.</p>
 *
 * @author Damian Flannery
 * @version 1.0
 */
public class GateKeeper {
    
    /** Creates a new instance of GateKeeper */
    public GateKeeper() {
    }
    
    // Global class logger
    static Logger log = Logger.getLogger(GateKeeper.class);
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link Datafile} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user      username or dn of user who is to be authorised.
     * @param datafile  element/entity that the user wishes to perform
     *                  operation on.
     * @param access    type of operation that the user is trying to
     *                  perform.
     * @param manager   manager object that will facilitate interaction
     *                  with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                  permission to perform operation.
     */
    public static void performAuthorisation(String user, Datafile datafile, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(datafile.getDatasetId().getInvestigationId());
        performAuthorisation(user, invList, access, datafile.getClass().toString(), datafile.toString(), manager);
    }//end method
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link Dataset} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user      username or dn of user who is to be authorised.
     * @param dataset   element/entity that the user wishes to perform
     *                  operation on.
     * @param access    type of operation that the user is trying to
     *                  perform.
     * @param manager   manager object that will facilitate interaction
     *                  with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                  permission to perform operation.
     */
    public static void performAuthorisation(String user, Dataset dataset, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(dataset.getInvestigationId());
        performAuthorisation(user, invList, access, dataset.getClass().toString(), dataset.toString(), manager);
    }//end method
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link Sample} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user      username or dn of user who is to be authorised.
     * @param sample    element/entity that the user wishes to perform
     *                  operation on.
     * @param access    type of operation that the user is trying to
     *                  perform.
     * @param manager   manager object that will facilitate interaction
     *                  with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                  permission to perform operation.
     */
    public static void performAuthorisation(String user, Sample sample, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(sample.getInvestigationId());
        performAuthorisation(user, invList, access, sample.getClass().toString(), sample.toString(), manager);
    }//end method
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link SampleParameter} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user          username or dn of user who is to be authorised.
     * @param sampleParam   element/entity that the user wishes to perform
     *                      operation on.
     * @param access        type of operation that the user is trying to
     *                      perform.
     * @param manager       manager object that will facilitate interaction
     *                      with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                      permission to perform operation.
     */
    public static void performAuthorisation(String user, SampleParameter sampleParam, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(sampleParam.getSample().getInvestigationId());
        performAuthorisation(user, invList, access, sampleParam.getClass().toString(), sampleParam.toString(), manager);
    }//end method
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link DatasetParameter} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user          username or dn of user who is to be authorised.
     * @param datasetParam  element/entity that the user wishes to perform
     *                      operation on.
     * @param access        type of operation that the user is trying to
     *                      perform.
     * @param manager       manager object that will facilitate interaction
     *                      with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                      permission to perform operation.
     */
    public static void performAuthorisation(String user, DatasetParameter datasetParam, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(datasetParam.getDataset().getInvestigationId());
        performAuthorisation(user, invList, access, datasetParam.getClass().toString(), datasetParam.toString(), manager);
    }//end method
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link DatafileParameter} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user          username or dn of user who is to be authorised.
     * @param datafileParam element/entity that the user wishes to perform
     *                      operation on.
     * @param access        type of operation that the user is trying to
     *                      perform.
     * @param manager       manager object that will facilitate interaction
     *                      with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                      permission to perform operation.
     */
    public static void performAuthorisation(String user, DatafileParameter datafileParam, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(datafileParam.getDatafile().getDatasetId().getInvestigationId());
        performAuthorisation(user, invList, access, datafileParam.getClass().toString(), datafileParam.toString(), manager);
    }//end method
    
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link Investigation} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * @param user          username or dn of user who is to be authorised.
     * @param investigation element/entity that the user wishes to perform
     *                      operation on.
     * @param access        type of operation that the user is trying to
     *                      perform.
     * @param manager       manager object that will facilitate interaction
     *                      with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                      permission to perform operation.
     */
    public static void performAuthorisation(String user, Investigation investigation, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        invList.add(investigation);
        performAuthorisation(user, invList, access, investigation.getClass().toString(), investigation.toString(), manager);
    }//end method
    
    /*
     
     */
    /**
     * Decides if a user has permission to perform an operation of type
     * {@link AccessType} on a {@link Study} element/entity.  If the
     * user does not have permission to perform aforementioned operation
     * then an {@link InsufficientPrivilegesException} will be thrown.
     *
     * <p>A Study can have multiple Investigations, so find them all and
     *  use each one to check authorisation. If a user has authorisation
     *  on any one of the investigations contained within the study then
     *  those permissions are extended to the parent Study element.</p>
     *
     * @param user          username or dn of user who is to be authorised.
     * @param study         element/entity that the user wishes to perform
     *                      operation on.
     * @param access        type of operation that the user is trying to
     *                      perform.
     * @param manager       manager object that will facilitate interaction
     *                      with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                      permission to perform operation.
     */
    public static void performAuthorisation(String user, Study study, AccessType access, EntityManager manager) throws InsufficientPrivilegesException {
        ArrayList<Investigation> invList = new ArrayList<Investigation>();
        for (Iterator<StudyInvestigation> iter = study.getStudyInvestigationCollection().iterator(); iter.hasNext(); ) {
            invList.add(iter.next().getInvestigation());
        }//end for 
        performAuthorisation(user, invList, access, study.getClass().toString(), study.toString(), manager);
    }//end method
    
    /**
     * Private method that ultimately does the low-level permission check
     * against the database.  This method retrieves all permission elements
     * associated with a given user and investigation pair.  If user has
     * been granted the appropriate access permission in the database then
     * the method returns without error.  Otherwise an exception with
     * appropriate details is raised, logged and thrown back to the caller.
     *
     * @param user              username or dn of user who is to be authorised.
     * @param investigations    collection if elements/entities that the user wishes
     *                          to perform operation on.
     * @param access            type of operation that the user is trying to perform.
     * @param element           name of element/entity type that user is really trying to
     *                          access in some way e.g. datafile.  This is used for
     *                          purposes only.
     * @param elementId         primary key of specific element/entity that user is trying
     *                          to access.
     * @param manager           manager object that will facilitate interaction
     *                          with underlying database
     * @throws InsufficientPrivilegesException  if user does not have
     *                          permission to perform operation.
     */
    private static void performAuthorisation(String user, Collection<Investigation> investigations, AccessType access, String element, String elementId, EntityManager manager) throws InsufficientPrivilegesException {
        
        
        for (Iterator<Investigation> iter = investigations.iterator(); iter.hasNext(); ) {
            //Investigation investigation = iter.next();
            
            for (Iterator<InvestigationLevelPermission> perms = iter.next().getInvestigationLevelPermissionCollection().iterator(); perms.hasNext(); ) {
                InvestigationLevelPermission perm = perms.next();
                
                //READ, UPDATE, DELETE, CREATE, ADMIN, FINE_GRAINED_ACCESS;
                switch (access) {
                    case READ:      if (perm.getPrmRead() == 1) {
                        log.debug("User: " + user + " granted " + access + " permission on " + element + "# " + elementId);
                        return;
                    }//end if
                    break;
                    
                    case UPDATE:    if (perm.getPrmUpdate() == 1){
                        log.debug("User: " + user + " granted " + access + " permission on " + element + "# " + elementId);
                        return;
                    }//end if
                    break;
                    
                    case DELETE:    if (perm.getPrmDelete() == 1) {
                        log.debug("User: " + user + " granted " + access + " permission on " + element + "# " + elementId);
                        return;
                    }//end if
                    break;
                    
                    case CREATE:    if (perm.getPrmCreate() == 1) {
                        log.debug("User: " + user + " granted " + access + " permission on " + element + "# " + elementId);
                        return;
                    }//end if
                    break;
                    
                    case ADMIN:     if (perm.getPrmAdmin() == 1) {
                        log.debug("User: " + user + " granted " + access + " permission on " + element + "# " + elementId);
                        return;
                    }//end if
                    break;
                    
                    //not yet used
                    case FINE_GRAINED_ACCESS:   log.warn("User: " + user + " granted " + access + " permission on " + element + "# " + elementId);
                    break;
                    
                }//end switch
                
            }//end for
        }//end for
        
        //if we get to here then user does not have permission so we need to throw an exception
        InsufficientPrivilegesException e = new InsufficientPrivilegesException("User#" + user + " does not have permission to perform '" + access + "' operation on " + element + "# " + elementId);
        log.warn(e.getStackTraceAsString(), e.getCause());
        throw(e);
    }//end method
    
}