
# openSCAP

OpenSCAP (Open Security Content Automation Protocol) is an open-source framework and collection of tools used for maintaining the security of enterprise computer systems. It is primarily used to automate security compliance auditing, vulnerability management, and system evaluation.

## Core Functions of OpenSCAP

  1. Auditing: It checks a system's configuration against standard security baselines and organizational policies (such as PCI-DSS, HIPAA, or DISA STIGs). If a system has insecure settings, OpenSCAP flags them.
    (scap downloads some policy files that include different organization security chek files that are basically a collection of xml and OVAL and .. files)

  2. Vulnerability Scanning: It scans operating systems and applications for known software flaws using standardized vulnerability lists, such as the CVE (Common Vulnerabilities and Exposures) database.

  3. Automated Remediation: When OpenSCAP identifies a non-compliant setting or a vulnerability, it can often generate automated remediation scripts (such as Bash scripts or Ansible playbooks) to fix the issue and bring the system back into compliance.

## installing openSCAP

OpenSCAP uses `scap` which is a line of specifications maintained by the **NIST**(national institute of standards and technology)

>To install OpenSCAP on Red Hat Enterprise Linux 8 and newer, on CentOS 8 and newer or on Fedora use the following command:
>
> `$ dnf install openscap-scanner`
>> for other systems refer to : <https://static.open-scap.org/openscap-1.3/oscap_user_manual.html>

After installing, all SCAP Security Guide security policies are in directory `/usr/share/xml/scap/ssg/content/`

## Displaying information about SCAP content
OpenSCAP mainly processes the XCCDF which is a standard way of expressing a checklist content and defines security checklists
It also combines with other specifications such as CPE, CCE and OVAL ***(An OVAL file is an XML document written in the Open Vulnerability and Assessment Language (OVAL)*** to create a SCAP-expressed checklist that can be processed by SCAP-validated products.

XCCDF is a specification language for writing security checklists, benchmarks, and related kinds of documents. An XCCDF document represents a structured collection of security configuration rules for some set of target systems.XCCDF documents are expressed in XML, and may be validated with an XML Schema-validating parser.

Information about an SCAP file can be displayed using the `$ oscap info` command.

The most common SCAP file type is an SCAP source data stream. In the following example, we will display information about SCAP source security guide *as previously mentiond* `/usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml` from the **scap-security-guide package**.
  
```
  $ oscap info /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml
  
  Document type: Source Data Stream
  
  Imported: 2021-01-12T04:50:11
  
  
  
  Stream: scap_org.open-scap_datastream_from_xccdf_ssg-rhel8-xccdf-1.2.xml
  
  Generated: (null)
  
  Version: 1.3
  
  Checklists:
  
          Ref-Id: scap_org.open-scap_cref_ssg-rhel8-xccdf-1.2.xml
  
                  Status: draft
  
                  Generated: 2021-01-12
  
                  Resolved: true
  
                  Profiles:
  
                          Title: CIS Red Hat Enterprise Linux 8 Benchmark
  
                                  Id: xccdf_org.ssgproject.content_profile_cis
  
                          Title: Unclassified Information in Non-federal Information Systems and Organizations (NIST 800-171)
  
                                  Id: xccdf_org.ssgproject.content_profile_cui
  
                          Title: Australian Cyber Security Centre (ACSC) Essential Eight
  
                                  Id: xccdf_org.ssgproject.content_profile_e8
  
                          Title: Health Insurance Portability and Accountability Act (HIPAA)
  
                                  Id: xccdf_org.ssgproject.content_profile_hipaa
  
                          Title: PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 8
  
                                  Id: xccdf_org.ssgproject.content_profile_pci-dss
  
                          Title: [DRAFT] DISA STIG for Red Hat Enterprise Linux 8
  
                                  Id: xccdf_org.ssgproject.content_profile_stig
  
                          Title: Protection Profile for General Purpose Operating Systems
  
                                  Id: xccdf_org.ssgproject.content_profile_ospp
  
                  Referenced check files:
  
                          ssg-rhel8-oval.xml
  
                                  system: http://oval.mitre.org/XMLSchema/oval-definitions-5
  
                          ssg-rhel8-ocil.xml
  
                                  system: http://scap.nist.gov/schema/ocil/2
  
                          security-data-oval-com.redhat.rhsa-RHEL8.xml
  
                                  system: http://oval.mitre.org/XMLSchema/oval-definitions-5
  
  Checks:
  
          Ref-Id: scap_org.open-scap_cref_ssg-rhel8-oval.xml
  
          Ref-Id: scap_org.open-scap_cref_ssg-rhel8-ocil.xml
  
          Ref-Id: scap_org.open-scap_cref_ssg-rhel8-cpe-oval.xml
  
          Ref-Id: scap_org.open-scap_cref_security-data-oval-com.redhat.rhsa-RHEL8.xml
  
  Dictionaries:
  
          Ref-Id: scap_org.open-scap_cref_ssg-rhel8-cpe-dictionary.xml

  ```


> - Document type describes what format the file is in. Common types include XCCDF, OVAL, source data stream and result data stream.
>
> - Imported is the date the file was imported for use with OpenSCAP. Since OpenSCAP uses the local filesystem and has no proprietary database format the imported >date is the same as file modification date.
>
> - Stream is the data stream ID.
>
> - Version is the version of the SCAP standard.
>
> - Checklists lists available checklists incorporated in the data stream that you can use for the --benchmark-id command line attribute with oscap xccdf eval. Also each checklist has the detailed information printed.
>
> - Status is the XCCDF Benchmark status. Common values include "accepted", "draft", "deprecated" and "incomplete". Please refer to the XCCDF specification for >details.
>
> - Generated date is the date the file was created or generated. This date is shown for XCCDF files and Checklists and is sourced from the XCCDF Status element.
>
> - Profiles lists available profiles, their titles and IDs that you can use for the --profile command line attribute.
>
> - Checks and Dictionaries lists OVAL checks components and CPE dictionaries components in the given data stream.
  

The oscap info command is also helpful with other SCAP file types such as SCAP result data stream (ARF) files.
(scap itself also produces theese files)

## Scanning

The main goal of OpenSCAP is to perform configuration and vulnerability scans of a local system. OpenSCAP is able to evaluate SCAP source data streams, XCCDF benchmarks and OVAL definitions and generate the appropriate results.

SCAP content can be provided either in a single file (as an SCAP source data stream), or as multiple separate XML files.
 can also be buncdled 


`$ oscap xccdf eval --profile PROFILE_ID --results-arf ARF_FILE --report REPORT_FILE SOURCE_DATA_STREAM_FILE`

- PROFILE_ID is the ID of an XCCDF profile

- ARF_FILE is the file path where the results in SCAP results data stream format (ARF) will be generated

- REPORT_FILE is the file path where a report in HTML format will be generated

- SOURCE_DATA_STREAM_FILE is the file path of the evaluated SCAP source data stream

## Evaluation and Results
When evaluating an XCCDF benchmark, oscap usually processes an XCCDF file, an OVAL file and the CPE dictionary. It performs system analysis and produces XCCDF results based on this analysis. The results of the scan do not have to be saved in a separate file but can be attached to the XCCDF file. The evaluation result of each XCCDF rule within an XCCDF checklist is printed to standard output stream. *(The CVE and CCE identifiers associated with the rules are printed as well.)*

**possible list of results :**
**XCCDF results**

| Result | Description | Example Situation |
|---|---|---|
| pass | The target system or system component satisfied all the conditions of the rule. |  |
| fail | The target system or system component did not satisfy all the conditions of the rule. |  |
| error | The checking engine could not complete the evaluation, therefore the status of the target’s compliance with the rule is not certain. | OpenSCAP was run with insufficient privileges and could not gather all of the necessary information. |
| unknown | The testing tool encountered some problem and the result is unknown. | OpenSCAP was unable to interpret the output of the checking engine (the output has no meaning to OpenSCAP). |
| notapplicable | The rule was not applicable to the target of the test. | The rule might have been specific to a different version of the target OS, or it might have been a test against a platform feature that was not installed. |
| notchecked | The rule was not evaluated by the checking engine. This status is designed for rules that have no `<xccdf:check>` elements or that correspond to an unsupported checking system. It may also correspond to a status returned by a checking engine if the checking engine does not support the indicated check code. | The rule does not reference any OVAL check. |
| notselected | The rule was not selected in the benchmark. OpenSCAP does not display rules that were not selected. | The rule exists in the benchmark, but is not a part of selected profile. |
| informational | The rule was checked, but the output from the checking engine is simply information for auditors or administrators; it is not a compliance category. This status value is designed for rules whose main purpose is to extract information from the target rather than test the target. |  |
| fixed | The rule had initially evaluated to "fail", but was then fixed by automated remediation and therefore it now evaluates as "pass". |  |

## remidation

OpenSCAP allows one to automatically remediate systems that have been found in a non-compliant state. For system remediation the rules in SCAP content need to have a remediation script attached. For example, the SCAP source data streams in the scap-security-guide package contain rules with remediation fix scripts.

### System remediation consists of the following steps:

  1. The oscap command performs a regular XCCDF evaluation.

  2. An assessment of the results is performed by evaluating the OVAL definitions. Each rule that has failed is marked as a candidate for remediation.

  3. The oscap program searches for an appropriate `<xccdf:fix>` element, resolves it, prepares the environment, and executes the fix script.

  4. Any output of the fix script is captured by oscap and stored within the `<xccdf:rule-result>` element. The return value of the fix script is stored as well.

  5. Whenever oscap executes a fix script, **it immediately evaluates the OVAL definition again** *(to verify that the fix script has been applied correctly)*. During this second run, if the OVAL evaluation returns success, the result of the rule is fixed, otherwise it is an error.

  6. Detailed results of the remediation are stored in an output XCCDF file. It contains two `<xccdf:TestResult>`elements. The first` <xccdf:TestResult> `element represents the scan prior to the remediation. The second `<xccdf:TestResult> `is derived from the first one and contains remediation results.


### html result
it also provides us with an option to evaluate the checks and fix them either during or after the scan and also the option to read the result files 
Another useful features of oscap is the ability to generate documents in a **human-readable HTML format**. This feature is used to generate security guides and checklists, which serve as a source of information, as well as guidance for secure system configuration.
# pros and cons 
## cons
  - IMO fully learning `SCAP` and its regulations and tolls can be challenging  for begginers especially if not familiar with linux systems
  - its mostly tied to [RHEL](https://www.redhat.com/en) systems and distributions (although not exclusive) and is not as supported on windows 
  - commands are usually longer than your typical linux commands
  - OVAL is not commonly taught in universities or other institutes even though we dont write it by hand and use xml or the GUI (workbench) instead 
  - scanning can take up recourses
## pros
  - open source and free and has a wide user base and support system and being open source means there are alot of eyes on it that make it more secure and trusted
  - backed by **NIST**
  - compatible with ansible and other automation tools 
  - visually appealing HTML outputs
  - suggets remedies that can be applied after vunerability scans
  - comes with a variety of security standards like `HIPPA` , `STIG` , ... that are included in the SSG**(SCAP security guide)**





source of this md  = <https://static.open-scap.org/openscap-1.3/oscap_user_manual.html>
